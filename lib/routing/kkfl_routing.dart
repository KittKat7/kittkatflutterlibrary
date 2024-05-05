/// Copyright 2024 kittkat; Licensed under the Apache License v2.0.
/// This file is part of kittkatflutterlibrary (https://github.com/KittKat7/kkfl_routing).
/// For license info go to http://www.apache.org/licenses/LICENSE-2.0

import 'package:flutter/material.dart';

/// A wrapper for getting [MaterialPageRoute]s. Simply because I don't want to have to use those all
/// the time. Example:
/// ```dart
/// Navigator.push(context, genRoute(NewWidgetPage(title: title)));
/// ```
genRoute(Widget widget) {
  return MaterialPageRoute(
    builder: (context) => widget,
  );
}// genRoute


Map<String, List<dynamic>> _namedRoutes = {};

Map<String, Widget Function(BuildContext)> generateNamedRoutes(Map<String, List> pageRoutes) {
	Map<String, Widget Function(BuildContext)> routes = {};
	for (String name in pageRoutes.keys) {
		routes[pageRoutes[name]![0]] = (context) => pageRoutes[name]![1];
	}
	_namedRoutes = pageRoutes;
	return routes;
}
