/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kittkatflutterlibrary).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'dart:async';
import 'dart:io';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:kittkatflutterlibrary/src/app_info.dart';
import 'package:path_provider/path_provider.dart';
import '../platform.dart';

/// Abstract class. The `initiate()` method initiates the _AppDocuments to be ready to read/write
/// documents. `readAsString(String path)` reads the specified file as a string.
abstract class _AppDocuments {
  /// `initiate()` is used to initiate any files that may require async.
  Future<void> initiate();
  /// Reads a string from specified file.
  Future<String?> readAppDoc(String path);
  /// Writes to a string to the specified file.
  Future<void> writeAppDoc(String path, String data);
}// _AppDocuments

/// [AppDocuments] allows for reading and writing files from the application document directory on
/// native apps, or from IndexedDB if on web.
class AppDocuments implements _AppDocuments {

  /// The [_AppDocuments] instance that will be used.
  late _AppDocuments _appDocuments;
  /// Whether [_appDocuments] has been initialized.
  bool isInitiated = false;

  /// Initialize [_appDocuments] to be [_IndexedDBDocuments] if web, or [_NativeAppDocuments] if
  /// native. After, set [isInitiated] to true.
  @override
  Future<void> initiate() async {
    _appDocuments = AppPlatform.isWeb? _IndexedDBDocuments() : _NativeAppDocuments();
    await _appDocuments.initiate();
    isInitiated = true;
  }// initiate
  
  /// Reads the specified app document [path] from [_appDocuments].
  @override
  Future<String?> readAppDoc(String path) async {
    if (!isInitiated) await initiate();
    try {
      return await _appDocuments.readAppDoc(path);
    } catch (e) {
      if (e is PathNotFoundException) return null;
    }
    return null;
  }// readAppDoc
  
  /// Writes the specified content [data] to [path] as a String.
  @override
  Future<void> writeAppDoc(String path, String data) async {
    if (!isInitiated) await initiate();
    await _appDocuments.writeAppDoc(path, data);
  }// writeAppDoc
}// AppDocuments

/// [_AppDocuments] for native apps.
class _NativeAppDocuments implements _AppDocuments {

  late String appDocumentPath;

  @override
  Future<void> initiate() async {
    appDocumentPath = AppPlatform.isWeb? '': (await getApplicationSupportDirectory()).path;
  }// initNativeAppDocuments

  @override
  Future<String?> readAppDoc(String path) async {
    return await _getFile(path).readAsString();
  }

  @override
  Future<void> writeAppDoc(String path, String data) async {
    await _getFile(path).writeAsString(data);
  }

  File _getFile(String path) {
    return File('$appDocumentPath/$path');
  }
  

}// _AppDocuments

/// [_AppDocuments] for web apps.
class _IndexedDBDocuments implements _AppDocuments {

  late Database _database;
  final String storeName = 'applicationSupportDirectory';

  @override
  Future<void> initiate() async {
    _database = await idbFactoryBrowser.open(
      AppInformation.name,
      version: 1,
      onUpgradeNeeded: (VersionChangeEvent e) {
        final db = e.database;
        db.createObjectStore(storeName);
  });
  }// initiate

  @override
  Future<String?> readAppDoc(String path) async {
    Transaction transaction = _database.transaction(storeName, "readonly");
    ObjectStore store = transaction.objectStore(storeName);
    String value = await store.getObject(path) as String;
    await transaction.completed;
    return value;
  }// readAsString

  @override
  Future<void> writeAppDoc(String path, String data) async {
    Transaction transaction = _database.transaction(storeName, "readwrite");
    ObjectStore store = transaction.objectStore(storeName);
    await store.put(data, path);
    await transaction.completed;
  }// writeAppDoc
}// _IndexedDBDocuments

