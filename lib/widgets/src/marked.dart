/// Copyright 2024 KittKat; Licensed under the Apache License v2.0.
/// This file is part of kkfl_widgets (https://github.com/KittKat7/kkfl_widgets).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// A simple wrapper for a markdown rendered text widget.
/// 
/// [Marked] is a simple wrapper for the flutter_markdown [MarkdownBody] widget. The [data]
/// parameter is the markdown text to be rendered. [scale] (defaults to 1) is used to set the
/// textScaleFactor in the style sheet. [selectable] (defaults to false) sets whether the [Marked]
/// text is selectable.
class Marked extends StatelessWidget {
  /// The data to be rendered.
  final String data;
  /// The scale of the 
  final double scale;
  /// Whether the text is selectable.
  final bool selectable;

  /// Creates a [Marked] widget using the provided parameters and has default values for all not
  /// required parameters.
  const Marked(this.data, {
    super.key, 
    this.scale = 1,
    this.selectable = false,
  });
  
  /// Build and return the [Marked] widget.
  @override
  Widget build(BuildContext context) {
    // Since this is based on MarkdownBody, return a MarkdownBody with the specified parameters
    // suplied.
    return MarkdownBody(
      key: key,
      data: data,
      styleSheet: MarkdownStyleSheet(textScaleFactor: scale),
      selectable: selectable,);
  }// build()
}// Marked