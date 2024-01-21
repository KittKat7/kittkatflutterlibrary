/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kittkatflutterlibrary).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/material.dart';
import 'package:kittkatflutterlibrary/src/platform.dart';
import 'package:provider/provider.dart';

/// Runs the provided [myApp] wrapped in a [ChangeNotifierProvider].
/// The AppTheme [theme] which is passed in will be the theme that is tracked and updated.
void runThemedApp(Widget myApp, AppTheme theme) {
  runApp(ChangeNotifierProvider<AppTheme>(
    create: (context) => theme,
    child: myApp
  ));
}// runThemedApp

/// The base colors, which all platforms have access to, including if the platform is classified as
/// lite.
const List<MaterialColor> _baseColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.purple,
];// _baseColors

/// Gets the available colors based on the platform, and returns a `List<MaterialColor>` of the
/// available colors. If the app is running in lite mode / web mode, then [_baseColors] will be
/// returned. Otherwise, the returned list will include more colors.
List<MaterialColor> getAvailableColors() {
  // If running in lite mode, return a copy of [_baseColors].
  if (!AppPlatform.isLite) return List.from(_baseColors);

  // Make a copy of [_baseColros] to add additional colors to.
  List<MaterialColor> availableColors = List.from(_baseColors);

  // Add additional colors to [availableColors].
  availableColors.addAll([
    Colors.pink,
    Colors.cyan,
    Colors.grey,
    Colors.indigo,
    Colors.teal,
  ]);

  // Return the available colors
  return availableColors;
}// getAvailableColors

/// A theme which is used for theming the app.
/// The [AppTheme] is a [ChangeNotifier] wrapper around [ThemeData]. This allows the theme to be
/// updated, and have widgets using the theme to be notified of the updates, and update themselves.
class AppTheme with ChangeNotifier {
  /// The material color of the theme.
  MaterialColor _themeColor;
  /// The light/dark/system mode of the theme.
  ThemeMode _themeMode;
  /// The actual theme data, light.
  ThemeData _themeData;
  /// The actual theme data, dark.
  ThemeData _themeDataDark;

  /// Constructor
  /// Creates an [AppTheme] object. If provided, [themeMode] is used to set [_themeMode] and
  /// [themeColor] is used to set [_themeColor]. Then [_themeData] is build using [_themeMode] and
  /// [_themeColor].
  AppTheme({ThemeMode themeMode = ThemeMode.system, MaterialColor themeColor = Colors.red})
  : _themeMode = themeMode, _themeColor = themeColor, _themeData = ThemeData(),
  _themeDataDark = ThemeData() {
    // Build the theme.
    _buildAppTheme();
  }// AppTheme

  /// Returns the theme data for the light theme.
  /// Returns the [_themeData] from the Provider.
  ThemeData getThemeDataLight(BuildContext context) {
    return Provider.of<AppTheme>(context)._themeData;
  }// getThemeData

  /// Returns the theme data for the dark theme.
  /// Returns the [_themeDataDark] from the Provider.
  ThemeData getThemeDataDark(BuildContext context) {
    return Provider.of<AppTheme>(context)._themeDataDark;
  }// getThemeData


  /// Returns the theme mode.
  /// Returns the [_themeMode] from the Provider.
  ThemeMode getThemeMode(BuildContext context) {
    return Provider.of<AppTheme>(context)._themeMode;
  }// getThemeMode()

  /// Builds the theme with the given settings.
  /// Uses the theme comonents, color, and mode, and sets [_themeData] to reflect those factors.
  /// Then calls `notifyListener()` to update anything using the theme.
  void _buildAppTheme() {
    // Update [_themeData] to reflect any changes to the components.
    _themeData = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _themeColor,
        brightness: Brightness.light,
      )
    );

    // Update [_themeData] to reflect any changes to the components.
    _themeDataDark = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _themeColor,
        brightness: Brightness.dark,
      )
    );
    // Notify the listeners.
    notifyListeners();
  }// buildThemeData

  /// Cycles the current color to the next color in the list of available colors.
  /// Changes the theme color to the next color in the list of available colors. If the current
  /// color is NOT in the list, then it resest to the begening of the list.
  void cylceColor() {
    // Get the list of available colors.
    List<MaterialColor> colors = getAvailableColors();
    // Determine the index of the current color and add 1 (for the index of the next color). If [i]
    // is outside of the bounds of the list, reset to 0. If the current color is not in the list,
    // [i] will be set to (-1 + 1) which is 0, and the new color will be from the start of the list.
    int i = colors.indexOf(_themeColor) + 1;
    // If [i] is out of bounds, use color 0, otherwise use color [i].
    if (i >= colors.length || i < 0) {
      _themeColor = colors[0];
    } else {
      _themeColor = colors[i];
    }// if else
    // Build the new theme.
    _buildAppTheme();
  }// cycleColors

  /// Sets the theme mode to dark.
  /// Sets the theme mode to dark mode, and runs `_buildAppTheme()` to build the ThemeData and
  /// notify the listeners.
  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    _buildAppTheme();
  }// setDarkMode

  /// Cycles through ThemeModes
  /// Determines what the current ThemeMode is, and cycles to the next one. It cycles from system to
  /// light to dark then back to system.
  void cycleThemeMode() {
    // Determine current ThemeMode, and cycle to the next.
    switch(_themeMode) {
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
        break;
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
    }// switch
    _buildAppTheme();
  }// cycleThemeMode
}// AppTheme
