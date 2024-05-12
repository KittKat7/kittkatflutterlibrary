import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:kittkatflutterlibrary/platform/kkfl_platform.dart';

void main() {
  test('Test whether the platform is reported correctly.', () {
    expect(kIsWeb, platformIsWeb);

    expect(defaultTargetPlatform == TargetPlatform.linux, platformIsLinux);
    expect(defaultTargetPlatform == TargetPlatform.windows, platformIsWindows);
    expect(defaultTargetPlatform == TargetPlatform.macOS, platformIsMacOs);

    expect(defaultTargetPlatform == TargetPlatform.android, platformIsAndroid);
    expect(defaultTargetPlatform == TargetPlatform.iOS, platformIsIOS);

    expect((platformIsLinux || platformIsWindows || platformIsMacOs),
        platformIsDesktop);
    expect((platformIsAndroid || platformIsIOS), platformIsMobile);
  });
}
