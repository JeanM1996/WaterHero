import 'package:flutter/material.dart';

class Styles {
  static TextStyle textStyle({
    FontWeight? fontWeight,
    double? fontSize,
    Color? textColor,
    TextDecoration? textDecoration,
    double? height,
  }) =>
      TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: textColor,
        decoration: textDecoration,
        height: height,
      );
}
