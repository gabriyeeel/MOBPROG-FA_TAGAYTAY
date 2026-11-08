import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_colors.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';

final ThemeData lightTheme = _buildTheme(Brightness.light);
final ThemeData darkTheme = _buildTheme(Brightness.dark);

Color dialogColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light ? kLightDialog : kDarkDialog;

Color menuColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light ? kLightMenu : kDarkMenu;

ThemeData _buildTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  final background = isLight ? kLightBackground : kDarkBackground;
  final primary = isLight ? kLightPrimary : kDarkPrimary;
  final text = isLight ? kLightText : kDarkText;
  final error = isLight ? kLightError : kDarkError;
  final errorContainer = isLight ? kLightErrorContainer : kDarkErrorContainer;
  final outline = isLight ? kLightOutline : kDarkOutline;

  final scheme = ColorScheme(
    brightness: brightness,
    primary: primary,
    onPrimary: background,
    secondary: primary,
    onSecondary: background,
    error: error,
    onError: background,
    errorContainer: errorContainer,
    surface: background,
    onSurface: text,
    outline: outline,
  );

  OutlineInputBorder border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(kFieldRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      foregroundColor: primary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: primary),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: text,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: text,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: text,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: text),
      bodyMedium: TextStyle(fontSize: 14, color: text),
      bodySmall: TextStyle(fontSize: 12, color: text),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: background,
        shape: const StadiumBorder(),
        minimumSize: const Size(64, 40),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: text,
        textStyle: const TextStyle(fontSize: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: border(outline),
      enabledBorder: border(outline),
      focusedBorder: border(primary, 2),
      errorBorder: border(error),
      focusedErrorBorder: border(error, 2),
      labelStyle: TextStyle(color: text),
      floatingLabelStyle: TextStyle(color: text),
      errorStyle: TextStyle(color: error, fontSize: 12),
      prefixStyle: TextStyle(color: text),
    ),
  );
}