///
/// Nombres de los colores generados en: https://it-tools.tech/color-converter
///

import 'package:flutter/material.dart';

// ignore: prefer-match-file-name, to consider file is ok
class SystemColors {
  SystemColors({
    required this.titles,
    required this.inputTitles,
    required this.paragraphs,
    required this.iconsPlaceholder,
    required this.inactiveButtonBorder,
    required this.inactiveInputBorder,
    required this.backgroundAccent,
    required this.box,
  });

  final Color blue = const Color(0xFF2C6DFA);
  final Color green = const Color(0xFF01B46B);
  final Color orange = const Color(0xFFF77F31);
  final Color red = const Color(0xFFF35D6C);
  final Color error = const Color(0xFFCD2D2D);
  final Color orangeAlternative = const Color(0xFFE1742D);
  final Color lightBlue = const Color(0xFF14AAF7);
  final Color black = const Color(0xFF000000);
  final Color darkOverlay = const Color(0xFF333333);
  final Color gray = const Color(0xFF9196A9);
  final Color lightGray = const Color(0xFFF3F5FB);
  final Color grey20 = const Color(0xFFACB5D1);
  final Color grey10 = const Color(0xFFF3F5FB);
  final Color grey50 = const Color(0xFFACB4C9);
  final Color grey90 = const Color(0xFF9196A9);
  final Color whiteGrey = const Color(0xFFf5f7fb);
  final Color background = const Color(0xFFF5F7FB);
  final Color white = const Color(0xFFFFFFFF);
  final Color blueLight = const Color(0xFF14AAF7);
  final Color whiteBereus = const Color(0xFFEBEBEB);
  final Color shadowWhite = const Color(0xFF162233);
  final Color switchBackground = const Color(0xFFEFEFF2);
  final Color shadowBlack = const Color(0xFF9196A9);
  final Color difuminatedBackground = const Color(0x00f5f7fb);
  final Color colorLightBlue = const Color(0xFF14AAF7);
  final Color yellow = const Color(0xFFFFBB01);

  /// Dynamics
  Color titles;
  Color inputTitles;
  Color paragraphs;
  Color iconsPlaceholder;
  Color inactiveButtonBorder;
  Color inactiveInputBorder;
  Color backgroundAccent;
  Color box;
}

///
// ignore: avoid-global-state, considering this is a global state
SystemColors colors = lightColors;

final SystemColors lightColors = SystemColors(
  titles: const Color(0xFF4D4D4D),
  inputTitles: const Color(0xFF5E5E5E),
  paragraphs: const Color(0xFF808080),
  iconsPlaceholder: const Color(0xFFC2C2C2),
  inactiveButtonBorder: const Color(0xFFD4D4D4),
  inactiveInputBorder: const Color(0xFFF2F5F9),
  backgroundAccent: const Color(0xFFFFFFFF),
  box: const Color(0xFFFFFFFF),
);

final SystemColors darkColors = SystemColors(
  titles: const Color(0xFFFFFFFF),
  inputTitles: const Color(0xFFE2E2E2),
  paragraphs: const Color(0xFFE2E2E2),
  iconsPlaceholder: const Color(0xFFB4B2B2),
  inactiveButtonBorder: const Color(0xFF686868),
  inactiveInputBorder: const Color(0xFF2D333A),
  backgroundAccent: const Color(0xFF22262B),
  box: const Color(0xFF3A414A),
);
