/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kkfl_platform).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/foundation.dart';

const bool platformIsWeb = kIsWeb;

final bool platformIsLinux = defaultTargetPlatform == TargetPlatform.linux;
final bool platformIsWindows = defaultTargetPlatform == TargetPlatform.windows;
final bool platformIsMacOs = defaultTargetPlatform == TargetPlatform.macOS;

final bool platformIsAndroid = defaultTargetPlatform == TargetPlatform.android;
final bool platformIsIOS = defaultTargetPlatform == TargetPlatform.iOS;

final bool platformIsDesktop =
    (platformIsLinux || platformIsWindows || platformIsMacOs);
final bool platformIsMobile = (platformIsAndroid || platformIsIOS);
