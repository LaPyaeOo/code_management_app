import 'package:flutter/material.dart';

import 'module/home_module/home_screen.dart';
import 'util/route_table.dart';

void main() {
  runApp(CodeManApp());
}

class CodeManApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeScreen.routeName,
      routes: appRoutes,
    );
  }
}
