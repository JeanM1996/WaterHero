import 'package:flutter/material.dart';
import 'package:waterhero/core/presentation/utils/text_theme_extension.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.textColor,
    this.fontWeight,
    this.textDecoration,
    this.maxLines,
    this.textAlign,
    this.fontSize = 14,
    this.overflow,
    this.height = 1,
    this.textType = TextType.custom,
    this.letterSpacing = 0,
    this.fontFamily = 'Inter',
  });
  final TextType textType;
  final String? text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final String fontFamily;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      maxLines: maxLines ?? 100,
      overflow: overflow,
      style: _style(context),
    );
  }

  TextStyle? _style(BuildContext context) {
    switch (textType) {
      case TextType.h1:
        return context.h1();
      case TextType.h2:
        return context.h2();
      case TextType.h3:
        return context.h3();
      case TextType.p1:
        return context.p1();
      case TextType.p2:
        return context.p2();
      case TextType.p3:
        return context.p3();
      case TextType.p4:
        return context.p4();
      case TextType.p5:
        return context.p5();
      case TextType.custom:
        return TextStyle(
          color: textColor ?? Colors.black,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: textDecoration ?? TextDecoration.none,
          decorationColor: textColor ?? Colors.black,
          fontFamily: fontFamily,
          height: height,
          letterSpacing: letterSpacing,
        );
    }
  }
}

enum TextType { h1, h2, h3, p1, p2, p3, p4, p5, custom }
