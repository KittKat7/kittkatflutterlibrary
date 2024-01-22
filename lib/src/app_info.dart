/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kittkatflutterlibrary).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import './theme.dart';

class AppInformation {
  static bool isInitiated = false;

  static String name = '';
  static AppTheme theme = AppTheme();
  static void setAppInfo(String appName, AppTheme appTheme) {
    name = appName;
    theme = appTheme;
    isInitiated = true;
  }// appNme
}// AppInformation