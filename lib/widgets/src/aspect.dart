/// Copyright 2024 KittKat; Licensed under the Apache License v2.0.
/// This file is part of kkfl_widgets (https://github.com/KittKat7/kkfl_widgets).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/material.dart';

/// [Aspect] is stateless widget which follows a set aspect ratio.
/// TODO comment
class Aspect extends StatelessWidget {

  static Size _getScreenSize(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  double aspectW = 1;
  // double aspectW = 10;
  double aspectH = 1;
  // double aspectH = 16;

  double scaleW = size.width / aspectW;
  double scaleH = size.height / aspectH;

  // ignore: unused_local_variable
  double drawW = scaleW / aspectW;
  // ignore: unused_local_variable
  double drawH = scaleH / aspectH;

  // double scale = scaleH * aspectW;
  // paddingW = (size.width - scale) / (size.width) / 2;
  // if (paddingW < 0.1) {
  // 	paddingW = 0.01;
  // }
  // // paddingW = 0.01;
  return size;
}

  static double aspectWidth = 1;
  static double aspectHeight = 1;

  final double width;
  final double height;
  final Widget child;

  Aspect({super.key, double? width, double? height, required this.child})
    : width = width ?? aspectWidth, height = height ?? aspectHeight;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = _getScreenSize(context);
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    final double screenWidthAspect = screenWidth / width;
    final double screenHeightAspect = screenHeight / height;

    EdgeInsets edgeInsets;
    // If the width is longer than aspect.
    if (screenWidthAspect > screenHeightAspect) {
      edgeInsets = EdgeInsets.symmetric(
        horizontal: (screenWidth - screenHeightAspect * width) / 2,
        vertical: 0,
      );
    }
    else {
      edgeInsets = const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      );
    }

    var padding = Padding(
      padding: edgeInsets,
      child: child,
    );
    return padding;
  } // end buidl
}