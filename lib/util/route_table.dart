import 'package:code_management_app/module/detail_module/detail_screen.dart';

import '../module/home_module/home_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailScreen.routeName: (context)=> DetailScreen(),
};
