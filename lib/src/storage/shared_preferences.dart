/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kittkatflutterlibrary).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:shared_preferences/shared_preferences.dart';

const String _kkflPrefix = 'kkfl-';
const _appPrefixDefault = 'kkflapp-';
String _appPrefix = '';
late final SharedPreferences _prefs;

/// Initiates the shared preferences.
/// Initiates the shared preferences with the prefix parameter. If a prefix is not passed, then the
/// default prefix will be used, [_appPrefixDefault].
Future<void> initiateSharedPreferences({String prefix = _appPrefixDefault}) async {
  _appPrefix = prefix;
  SharedPreferences.setPrefix('');
  _prefs = await SharedPreferences.getInstance();
}// initiateSharedPreferences()

/// Gets and returns a shared preference value.
/// 
/// Uses [_prefs] to get a shared preferese with the key [prefix] + [key]. If [prefix] is not
/// provided, [_appPrefix] will be used.
dynamic getPreference(String key, {String? prefix}) {
  // Determine the prefix, if there was no prefixed provided, use the [appPrefix] as the prefix.
  prefix = prefix??_appPrefix;
  // Set the key to be the key combined with the prefix.
  key = '$prefix$key';
  // Return the value stored under 
  return _prefs.get(key);
}// getPreference()

bool? prefsGetBool(String key) => _prefs.getBool('$_appPrefix$key');
double? prefsGetDouble(String key) => _prefs.getDouble('$_appPrefix$key');
int? prefsGetInt(String key) => _prefs.getInt('$_appPrefix$key');
String? prefsGetString(String key) => _prefs.getString('$_appPrefix$key');
List<String>? prefsGetStringList(String key) => _prefs.getStringList('$_appPrefix$key');
Set<String>? prefsGetKeys() => _prefs.getKeys();

Future<bool> prefsSetBool(String key, bool value) => _prefs.setBool('$_appPrefix$key', value);
Future<bool> prefsSetDouble(String key, double value) => _prefs.setDouble('$_appPrefix$key', value);
Future<bool> prefsSetInt(String key, int value) => _prefs.setInt('$_appPrefix$key', value);
Future<bool> prefsSetString(String key, String value) => _prefs.setString('$_appPrefix$key', value);
Future<bool> prefsSetStringList(String key, List<String> value) => _prefs.setStringList('$_appPrefix$key', value);







