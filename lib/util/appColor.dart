import 'package:flutter/material.dart';

class AppColor {
  static final AppColor _singleton = AppColor._internal();

  factory AppColor() {
    return _singleton;
  }

  AppColor._internal();

  final Color primaryColor = Color.fromARGB(200, 255, 76, 41);
  final Color toolBarColor = Color.fromARGB(250, 239, 226, 192);
}