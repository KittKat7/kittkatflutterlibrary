/// Copyright 2024 KittKat; Licensed under the Apache License v2.0.
/// This file is part of kkfl_widgets (https://github.com/KittKat7/kkfl_widgets).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/widgets.dart';

/// A simple wrapper for the [Text] widget.
/// Yes, this actually a wrapper for the [Text] widget. Why? Because I am lazy and I don't want to
/// have to do all the styling stuff all the time. This is a simpler way to do some basic styling
/// to a [Text] widget.
class SimpleText extends StatelessWidget {
  /// The string to be rendered.
  final String data;
  /// Whether or not the text is bold.
  final bool isBold;
  /// Whether or not the text is italic.
  final bool isItalic;
  /// The font size of the text.
  final double? fontSize;

  /// Constructor
  const SimpleText(this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontSize,
  });// SimpleText

  /// Builds and returns a [Text] widget with the provided parameters.
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      key: key,
      style: TextStyle(
        fontWeight: isBold? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic? FontStyle.italic : FontStyle.normal,
        fontSize: fontSize,
      ),// TextStyle
    );// Text
  }// buidl
}// SimpleText