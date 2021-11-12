import 'package:flutter/material.dart';

class SizeConfig {
  static BuildContext? appContext;
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    appContext = context;
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
  }

  static double height(double height) {
    double screenHeight = _mediaQueryData!.size.height / 100;
    return height * screenHeight;
  }

  static double width(double width) {
    double screenWidth = _mediaQueryData!.size.width / 100;
    return width * screenWidth;
  }

  static double textSize(double textSize) {
    double screenWidth = _mediaQueryData!.size.width / 100;
    return textSize * screenWidth;
  }
}
