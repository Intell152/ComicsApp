import 'package:flutter/material.dart';

import 'package:comics_app/src/screens/details_screen.dart';
import 'package:comics_app/src/screens/home_screen.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const HomeScreen(),
    'details': (BuildContext context) => const DetailsScreen(),
  };
}
