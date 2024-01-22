/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kittkatflutterlibrary).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'dart:async';
import 'dart:io';
import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:kittkatflutterlibrary/src/kkfl_app.dart';
import 'package:path_provider/path_provider.dart';
import '../platform.dart';

/// Abstract class. The `initiate()` method initiates the _AppInternalFiles to be ready to read/write
/// documents. `readAsString(String path)` reads the specified file as a string.
abstract class _AppInternalFiles {
  /// `initiate()` is used to initiate any files that may require async.
  Future<void> initialize();
  /// Reads a string from specified file.
  Future<String?> readString(String path);
  /// Writes to a string to the specified file.
  Future<void> writeString(String path, String data);
}// _AppInternalFiles


/// [AppInternalFiles] allows for reading and writing files from the application document directory on
/// native apps, or from IndexedDB if on web.
class AppInternalFiles implements _AppInternalFiles {

  /// The [_AppInternalFiles] instance that will be used.
  late _AppInternalFiles _appInternalFiles;
  /// Whether [_appInternalFiles] has been initialized.
  bool isInitiated = false;

  /// Initialize [_appInternalFiles] to be [_IndexedDBInternalFiles] if web, or [_NativeAppInternalFiles] if
  /// native. After, set [isInitiated] to true.
  @override
  Future<void> initialize() async {
    _appInternalFiles = AppPlatform.isWeb? _IndexedDBInternalFiles() : _NativeAppInternalFiles();
    await _appInternalFiles.initialize();
    isInitiated = true;
  }// initiate
  
  /// Reads the specified app document [path] from [_appInternalFiles].
  @override
  Future<String?> readString(String path) async {
    if (!isInitiated) await initialize();
    try {
      return await _appInternalFiles.readString(path);
    } catch (e) {
      if (e is PathNotFoundException) return null;
    }
    return null;
  }// readAppDoc
  
  /// Writes the specified content [data] to [path] as a String.
  @override
  Future<void> writeString(String path, String data) async {
    if (!isInitiated) await initialize();
    await _appInternalFiles.writeString(path, data);
  }// writeAppDoc
}// AppInternalFiles


/// [_AppInternalFiles] for native apps.
class _NativeAppInternalFiles implements _AppInternalFiles {

  late String appDocumentPath;

  @override
  Future<void> initialize() async {
    appDocumentPath = (await getApplicationSupportDirectory()).path;
  }// initiate

  @override
  Future<String?> readString(String path) async {
    return await _getFile(path).readAsString();
  }// readAppDoc

  @override
  Future<void> writeString(String path, String data) async {
    await _getFile(path).writeAsString(data);
  }// writeAppDoc

  File _getFile(String path) {
    return File('$appDocumentPath/$path');
  }// _getFile
  

}// _AppInternalFiles


/// [_AppInternalFiles] for web apps.
class _IndexedDBInternalFiles implements _AppInternalFiles {

  late Database _database;
  final String storeName = 'applicationSupportDirectory';

  @override
  Future<void> initialize() async {
    _database = await idbFactoryBrowser.open(
      AppInformation.name,
      version: 1,
      onUpgradeNeeded: (VersionChangeEvent e) {
        final db = e.database;
        db.createObjectStore(storeName);
    });
  }// initiate

  @override
  Future<String?> readString(String path) async {
    Transaction transaction = _database.transaction(storeName, "readonly");
    ObjectStore store = transaction.objectStore(storeName);
    String value = await store.getObject(path) as String;
    await transaction.completed;
    return value;
  }// readAsString

  @override
  Future<void> writeString(String path, String data) async {
    Transaction transaction = _database.transaction(storeName, "readwrite");
    ObjectStore store = transaction.objectStore(storeName);
    await store.put(data, path);
    await transaction.completed;
  }// writeAppDoc
}// _IndexedDBInternalFiles

