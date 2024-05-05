/// Copyright 2024 KittKat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kkfl_lang).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

library language;

/// A map of the keys and values for the currently loaded language. The keys are when the programmer
/// types in, and the values are what displayed in the app.
Map<String, String> _languageMap = {};

/// Sets the language currently loaded into the app. [languageMap] is a map of the keys and values
/// for the currently loaded language. The keys are when the programmer types in, and the values are
/// what displayed in the app.
void setLangMap(Map<String, String> languageMap) {
	_languageMap = languageMap;
}// setLang

/// Returns the language string for the provided [key]. The list [params] is used for any variables
/// that need to be displayed in the language string. For example, if you needed the string "The
/// time is 10:00", instead of using `'${getLang('time')} 10:00'` it would be better practice to
/// have the lang string for 'time' be 'The time is \${0}' and use `${getLang('time'), ['10:00']}`.
/// This method allows for different languages to have different sentence structure, and control
/// over where these variables go.
String getLang(String key, [List params = const []]) {
	String str = _languageMap[key]!;
	for (int i = 0; i < params.length; i++) {
		str = str.replaceAll('\${$i}', params[i].toString());
	}
	// for (String key in params.keys) {
	// 	str.replaceAll('\${key}', params[key]);
	// }
  str = str.replaceAll(RegExp('\\\$\\{\\d+\\}'), '');
	return str;
}// getLang

// bool contains(String key) {
// 	return _languageMap.containsKey(key);
// }