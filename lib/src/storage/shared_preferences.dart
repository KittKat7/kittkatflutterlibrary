/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary. https://github.com/KittKat7/kittkatflutterlibrary
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:shared_preferences/shared_preferences.dart';

const String kflPrefix = 'kfl-';
const appPrefixDefault = 'kflapp-';
String appPrefix = '';
late final SharedPreferences prefs;

/// Initiates the shared preferences.
/// 
/// Initiates the shared preferences with the prefix parameter. If a prefix is not passed, then the
/// default prefix will be used, [appPrefixDefault].
void initiateSharedPreferences({String prefix = appPrefixDefault}) {
  appPrefix = prefix;
  SharedPreferences.setPrefix('');
  SharedPreferences.getInstance();
}//e initiateSharedPreferences()

/// Gets and returns a shared preference value.
/// 
/// Uses [prefs] to get a shared preferese with the key [prefix] + [key]. If [prefix] is not
/// provided, [appPrefix] will be used.
dynamic getPreference(String key, {String? prefix}) {
  // Determine the prefix, if there was no prefixed provided, use the [appPrefix] as the prefix.
  prefix = prefix??appPrefix;
  // Set the key to be the key combined with the prefix.
  key = '$prefix$key';
  // Return the value stored under 
  return prefs.get(key);
}//e getPreference()








