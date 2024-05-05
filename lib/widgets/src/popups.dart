/// Copyright 2024 KittKat; Licensed under the Apache License v2.0.
/// This file is part of kkfl_widgets (https://github.com/KittKat7/kkfl_widgets).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/material.dart';
import './marked.dart';

/// TODO
void confirmPopup(BuildContext context, String title, String question, Function() onConfirm) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content: Marked(question),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              // Handle cancel
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              // Handle confirm
              Navigator.of(context).pop();
              onConfirm();
            },
          ),
        ],
      );
    },
  );
}