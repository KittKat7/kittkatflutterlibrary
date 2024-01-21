/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kittkatflutterlibrary).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/foundation.dart';



class AppPlatform {
  static const isWeb = kIsWeb;
  static final isLinux = defaultTargetPlatform == TargetPlatform.linux;
  static final isWindows = defaultTargetPlatform == TargetPlatform.windows;
  static final isMacOs = defaultTargetPlatform == TargetPlatform.macOS;
  static final isAndroid = defaultTargetPlatform == TargetPlatform.android;
  static final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

  static final bool isDesktop = (isLinux || isWindows || isMacOs);
  static final bool isMobile = (isAndroid || isIOS);

  static bool _isLite = false;
  static set isLite(bool isLite) => _isLite = isLite;
  static bool get isLite => isWeb || _isLite;
}