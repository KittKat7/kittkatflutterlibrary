/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary. https://github.com/KittKat7/kittkatflutterlibrary
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/src/platform.dart';
// import 'package:provider/provider.dart';

const List<MaterialColor> _baseColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.purple,
];

List<MaterialColor> getAvailableColors() {
  if (!AppPlatform.isLite) return List.from(_baseColors);
  List<MaterialColor> availableColors = List.from(_baseColors);

  availableColors.addAll([
    Colors.pink,
    Colors.cyan,
    Colors.grey,
    Colors.indigo,
    Colors.teal,
  ]);
  return availableColors;
}


class AppTheme extends ChangeNotifier {
  MaterialColor themeColor;
  ThemeMode themeMode;
  ThemeData themeData;

  // ThemeMode mode = Theme.of(context).brightness;

  AppTheme({required this.themeMode, required this.themeColor})
  : themeData = ThemeData(
    brightness: Brightness.light,
    primarySwatch: themeColor,
  );

  ThemeData getTheme() {
    return themeData;
  }

  // Brightness _modeToBrightness() {
  //   if (themeMode == ThemeMode.light) {
  //     return Brightness.light;
  //   } else if (themeMode == ThemeMode.dark) {
  //     return Brightness.dark;
  //   } else {
  //     return Theme.of(context).brightness
  //   }
  // }
}

// // MaterialColor defColor = Colors.amber;
// MaterialColor defColor = Colors.blue;

// Map<String, MaterialColor> themeColorMap = {
//   'red': Colors.red, 
//   'orange': Colors.orange,
//   'yellow': Colors.yellow,
//   'green': Colors.green,
//   'blue': Colors.blue,
//   'purple': Colors.purple,
//   'cyan': Colors.cyan
// };

// List<String> get getAvailableThemeColors {
//   return themeColorMap.keys.toList();
// }

// MaterialColor getThemeColor(String c) {
//   if (themeColorMap.containsKey(c)) {
//     return themeColorMap.values.first;
//   }
//   return themeColorMap[c]!;
// }

// late MaterialColor themeColor;

// Future<void> initTheme() async {
//   if (!themeColorMap.containsKey(getSetting('themeColor'))) {
//   flutterkatSettings['themeColor'] = 'red';
//   }
//   themeColor = themeColorMap[getSetting('themeColor')]!;
//   // themeColor = themeColorMap['red']!;
// }

// ThemeData getLightTheme(context) {
//   return Provider.of<ColorTheme>(context).lightTheme;
// }

// ThemeData getDarkTheme(context) {
//   return Provider.of<ColorTheme>(context).darkTheme;
// }

// ThemeData getTheme(context) {
//   if (Theme.of(context).brightness == Brightness.light) {
//     return Provider.of<ColorTheme>(context).lightTheme;
//   }
//   else if (Theme.of(context).brightness == Brightness.dark) {
//     return Provider.of<ColorTheme>(context).darkTheme;
//   } else {
//     return Provider.of<ColorTheme>(context).theme;
//   }
// }

// ThemeMode getThemeMode(context) {
//   return Provider.of<AppThemeMode>(context).mode;
// }

// AppThemeMode getAppThemeMode(context) {
//   return Provider.of<AppThemeMode>(context, listen: false);
// }

// class AppThemeMode with ChangeNotifier {
//   ThemeMode mode = getSetting('themeMode') == 'light' ? ThemeMode.light : getSetting('themeMode') == 'dark' ? ThemeMode.dark : ThemeMode.system;
  
//   setLightMode() { mode = ThemeMode.light; flutterkatSettings['themeMode'] = 'light'; saveSettings(); return notifyListeners(); }
//   setDarkMode() { mode = ThemeMode.dark; flutterkatSettings['themeMode'] = 'dark'; saveSettings(); return notifyListeners(); }
//   setAutoMode() { mode = ThemeMode.system; flutterkatSettings['themeMode'] = 'auto'; saveSettings(); return notifyListeners(); }
// }

// class ColorTheme with ChangeNotifier{

// 	ThemeData lightTheme = ThemeData(
//     colorScheme: ColorScheme.fromSwatch(
//       primarySwatch: themeColor,
//       brightness: Brightness.light
//     ),
//     primarySwatch: themeColor,
//     brightness: Brightness.light,
//   );

// 	ThemeData darkTheme = ThemeData(
//     colorScheme: ColorScheme.fromSwatch(
//       primarySwatch: themeColor,
//       brightness: Brightness.dark
//     ),
//     primarySwatch: themeColor,
//     brightness: Brightness.dark,
//   );

//   ThemeData theme = ThemeData(

//   );

// 	setColor(String colorName)
// 	{
// 		themeColor = themeColorMap[colorName] ?? themeColor;
//     flutterkatSettings['themeColor'] = colorName;
//     saveSettings();

// 		lightTheme = ThemeData(
//       colorScheme: ColorScheme.fromSwatch(
//         primarySwatch: themeColor,
//         brightness: Brightness.light
//       ),
// 			primarySwatch: themeColor,
// 			brightness: Brightness.light,
// 		);
// 		darkTheme = ThemeData(
//       colorScheme: ColorScheme.fromSwatch(
//         primarySwatch: themeColor,
//         brightness: Brightness.dark
//       ),
// 			primarySwatch: themeColor,
// 			brightness: Brightness.dark,
// 		);
// 		return notifyListeners();
// 	} // end setColor

// 	setColorCyan()
// 	{
// 		themeColor = Colors.cyan;
// 		lightTheme = ThemeData(
//       colorScheme: ColorScheme.fromSwatch(
//         primarySwatch: themeColor,
//         brightness: Brightness.light
//       ),
// 			primarySwatch: themeColor,
// 			brightness: Brightness.light,
// 		);
// 		darkTheme = ThemeData(
//       colorScheme: ColorScheme.fromSwatch(
//         primarySwatch: themeColor,
//         brightness: Brightness.dark
//       ),
// 			primarySwatch: themeColor,
// 			brightness: Brightness.dark,
// 		);
// 		return notifyListeners();
// 	} // end setColor

// 	cycleColor()
// 	{
// 		if (!themeColorMap.values.toList().contains(themeColor)) {
// 			setColor(themeColorMap.keys.toList()[0]);
// 		} else {
// 			int index = themeColorMap.values.toList().indexOf(themeColor) + 1;
// 			setColor(themeColorMap.keys.toList()[index >= (themeColorMap.keys.toList().length - 1) ? 0 : index]);
// 		}
// 	} // end cycleColor
// }



// ColorTheme getColorTheme(BuildContext context) {
// 	return Provider.of<ColorTheme>(context, listen: false);
// }

// ColorScheme colorScheme(BuildContext context) {
//   return Theme.of(context).colorScheme;
// }