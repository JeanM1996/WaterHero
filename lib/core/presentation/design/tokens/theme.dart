import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waterhero/core/presentation/design/tokens/colors.dart';
import 'package:waterhero/core/presentation/design/tokens/styles.dart';

class Theme {
  ThemeData theme = ThemeData(
    useMaterial3: true,
    primaryColor: colors.blue,
    fontFamily: "Figtree",
    scaffoldBackgroundColor: colors.inactiveInputBorder,
    dialogBackgroundColor: colors.inactiveInputBorder,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colors.blue,
      selectionColor: colors.blue.withOpacity(.50),
      selectionHandleColor: colors.blue,
    ),
    hintColor: colors.gray.withOpacity(.50),
    focusColor: colors.blue,
    textTheme: TextTheme(
      bodyLarge: Styles.textStyle(
        textColor: colors.paragraphs,
        fontSize: 18,
      ),
      bodyMedium: Styles.textStyle(
        textColor: colors.paragraphs,
        fontSize: 16,
      ),
      displayLarge: Styles.textStyle(
        textColor: colors.titles,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: Styles.textStyle(
        textColor: colors.paragraphs,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: Styles.textStyle(
        textColor: colors.iconsPlaceholder,
        fontSize: 15,
      ),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,
      foregroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return colors.gray;
        }
        if (states.contains(MaterialState.selected)) {
          return colors.blue;
        }
        return null;
      }),
      //color of circular progress indicator

      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return colors.blue;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return colors.blue;
        }
        return null;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return colors.blue;
        }
        return null;
      }),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: colors.white,
      headerBackgroundColor: colors.white,
      headerHeadlineStyle: Styles.textStyle(
        textColor: colors.titles,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
      surfaceTintColor: colors.white,
      dayBackgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return colors.blue;
        }
        return null;
      }),
      todayBackgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return colors.blue;
        }
        return null;
      }),
      todayForegroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return colors.white;
        }
        return null;
      }),
      todayBorder: BorderSide(
        color: colors.red,
        width: 1,
      ),
    ),
    //Color scheme considering primary blue and text balck
    colorScheme: ColorScheme(
      primary: colors.blue,
      secondary: colors.blue,
      surface: colors.white,
      background: colors.white,
      error: colors.red,
      onPrimary: colors.white,
      onSecondary: colors.white,
      onSurface: colors.black,
      onBackground: colors.black,
      onError: colors.white,
      brightness: Brightness.light,
    ),
  );
}
