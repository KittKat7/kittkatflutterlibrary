/// Copyright 2024 KittKat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kkfl_theming).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The theme of the app, globally accessable.
AppTheme _appTheme = AppTheme();
AppTheme get appTheme => _appTheme;


class ThemedWidget extends StatefulWidget {
  final Widget widget;
  final AppTheme theme;

  const  ThemedWidget({super.key, required this.widget, required this.theme});
  @override
  State<ThemedWidget> createState() => _ThemedWidgetState();
}// ThemedWidget

class _ThemedWidgetState extends State<ThemedWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppTheme>(
      create: (context) => widget.theme,
      child: widget.widget
    );
  }
}// _ThemedWidgetState

/// A theme which is used for theming the app.
/// The [AppTheme] is a [ChangeNotifier] wrapper around [ThemeData]. This allows the theme to be
/// updated, and have widgets using the theme to be notified of the updates, and update themselves.
class AppTheme with ChangeNotifier {
  /// The material color of the theme.
  Color _themeColor;
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
  AppTheme({ThemeMode themeMode = ThemeMode.system, Color themeColor = Colors.red})
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
      colorSchemeSeed: _themeColor,
      brightness: Brightness.light
      // colorScheme: ColorScheme.fromSwatch(
      //   primarySwatch: _themeColor,
      //   brightness: Brightness.light,
      // )
    );

    // Update [_themeData] to reflect any changes to the components.
    _themeDataDark = ThemeData(
      colorSchemeSeed: _themeColor,
      brightness: Brightness.dark
      // colorScheme: ColorScheme.fromSwatch(
      //   primarySwatch: _themeColor,
      //   brightness: Brightness.dark,
      // )
    );
    // Notify the listeners.
    notifyListeners();
  }// buildThemeData

  /// Sets the theme mode to light.
  /// Sets the theme mode to light mode, and runs `_buildAppTheme()` to build the ThemeData and
  /// notify the listeners.
  void setLightMode() {
    _themeMode = ThemeMode.light;
    _buildAppTheme();
  }// setLightMode

  /// Sets the theme mode to dark.
  /// Sets the theme mode to dark mode, and runs `_buildAppTheme()` to build the ThemeData and
  /// notify the listeners.
  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    _buildAppTheme();
  }// setDarkMode

  /// Sets the theme mode to system.
  /// Sets the theme mode to system mode, and runs `_buildAppTheme()` to build the ThemeData and
  /// notify the listeners.
  void setSystemMode() {
    _themeMode = ThemeMode.system;
    _buildAppTheme();
  }// setSystemMode

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

  /// Sets the theme color to be the provided color.
  /// Takes the parameter [color] and sets [_themeColor] to match. Then has the theme be build and
  /// notify listeners.
  void setColor(Color color) {
    _themeColor = color;
    _buildAppTheme();
  }// setColor
}// AppTheme


ColorScheme colorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}// colorScheme