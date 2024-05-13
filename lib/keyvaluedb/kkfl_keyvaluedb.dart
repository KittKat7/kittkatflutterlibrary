import 'dart:convert';
import 'dart:io';

import 'package:kittkatflutterlibrary/platform/kkfl_platform.dart';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:path_provider/path_provider.dart';

const String _metadataKey = "kkflKeyValueDB";
const Map<String, dynamic> _metadataValue = {"version": 2024051100};
const String _dbName = "kkflKeyValueDB";

/// An abstract KeyValueDB class, expected to be accessed by using
/// ```
/// // Get a value
/// KeyValueDB.getValue(String);
/// // Set a value
/// KeyValueDB.setValue(String, dynamic);
/// ```
/// Must be initialized before use
/// ```
/// KeyValueDB.init();
/// ```
abstract class KeyValueDB {
  /// A static instance of KeyValueDB, can be a web, desktop, or mobile instance.
  static _KeyValueDB? _database;

  /// Initialize the database. This will set the active instance of the database, and will
  /// initialize depending on whether the system is web, desktop, or mobile.
  static Future<void> init(String dbName) async {
    // If the database has already been initialized, return.
    if (_database != null) return;

    // If the platform is web, load the web database.
    if (platformIsWeb) {
      _database = await _WebKeyValueDB.open(dbName);
    } else if (platformIsDesktop) {
      _database = await _DesktopKeyValueDB.open(dbName);
    }
  }

  /// Get and return the value corosponding to the key, null if the key does not exist.
  static dynamic getValue(String key) {
    return _database!.getValue(key);
  }

  /// Sets the value in the database, returns true when the save is complete, however, it runs async
  /// so you have to wait for the return. The value is stored imidiatelly in mem, but async to disk.
  static Future<bool> setValue(String key, dynamic value) async {
    return await _database!.setValue(key, value);
  }
}

/// Defines the actions that need to be able to be performed by the platform database instances.
abstract interface class _KeyValueDB {
  /// Stores the data in memory for instant gets.
  abstract Map<String, dynamic> dbMap;

  /// Gets the value from the database.
  dynamic getValue(String key);

  /// Sets the value in the database, memory is instant, but saving to persistant is async. Returns
  /// true once saved to persistant.
  Future<bool> setValue(String key, dynamic value);
}

/// Implements [_KeyValueDB] for storing the data on a web platform. Should only be used by
/// KeyValueDB when it deems nececary.
class _WebKeyValueDB implements _KeyValueDB {
  /// Name of the data store/table in the database
  static const String _storeName = "data";

  /// The instance of the IndexedDB database to use for reading and storing data
  late Database _db;

  @override
  late Map<String, dynamic> dbMap;

  _WebKeyValueDB._();

  /// Opens the database, and returns an instance of this class
  static Future<_WebKeyValueDB> open([String dbName = _dbName]) async {
    // If there is already an instance, return that
    _WebKeyValueDB kvdb = _WebKeyValueDB._();

    IdbFactory? idbFactory = getIdbFactory();

    // open the database
    kvdb._db = await idbFactory!.open(dbName, version: 1,
        onUpgradeNeeded: (VersionChangeEvent event) {
      Database db = event.database;
      // create the store
      db.createObjectStore(_storeName);
    });

    var txn = kvdb._db.transaction(_storeName, "readwrite");
    var store = txn.objectStore(_storeName);
    print(await store.getAllKeys());
    List<String> keys = (await store.getAllKeys()).cast<String>();

    for (String k in keys) {
      kvdb.dbMap[k] = (await store.getObject(k))!;
    }

    await txn.completed;

    if (!kvdb.dbMap.containsKey(_metadataKey)) {
      await kvdb.setValue(_metadataKey, _metadataValue);
    }

    return kvdb;
  }

  @override
  dynamic getValue(String key) {
    return dbMap[key];
  }

  @override
  Future<bool> setValue(String key, dynamic value) async {
    dbMap[key] = value;
    var txn = _db.transaction(_storeName, "readwrite");
    var store = txn.objectStore(_storeName);
    await store.put(value, key);
    await txn.completed;
    return true;
  }
}

/// Implements [_KeyValueDB] for desktop platforms. Used files in ApplicationSupport directory for
/// persistant storage. Should only be used by [KeyValueDB] when deemed nececary.
class _DesktopKeyValueDB implements _KeyValueDB {
  @override
  late Map<String, dynamic> dbMap;

  static late String directoryPath;

  late File localFile;

  _DesktopKeyValueDB._();

  /// Opens the database, and returns an instance of this class
  static Future<_DesktopKeyValueDB> open([String dbName = _dbName]) async {
    // If there is already an instance, return that
    _DesktopKeyValueDB kvdb = _DesktopKeyValueDB._();
    kvdb.dbMap = {};

    // The path of the application support files.
    directoryPath = (await getApplicationSupportDirectory()).path;
    // The local file which is used to store the database.
    kvdb.localFile = File("$directoryPath/$dbName.json");
    if (!await kvdb.localFile.exists()) {
      await kvdb.localFile.create();
      await kvdb.setValue(_metadataKey, _metadataValue);
    }

    // Set the in memory database map to be the decoded json from the file.
    kvdb.dbMap = json.decode(await kvdb.localFile.readAsString());

    if (!kvdb.dbMap.containsKey(_metadataKey)) {
      await kvdb.setValue(_metadataKey, _metadataValue);
    }

    // Return the instance of _KeyValueDB
    return kvdb;
  }

  @override
  dynamic getValue(String key) {
    return dbMap[key];
  }

  @override
  Future<bool> setValue(String key, dynamic value) async {
    dbMap[key] = value;
    await localFile.writeAsString(json.encode(dbMap));
    return true;
  }
}
