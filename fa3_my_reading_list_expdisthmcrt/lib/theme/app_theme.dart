import 'package:fa3_my_reading_list_expdisthmcrt/constants.dart';
import 'package:flutter/material.dart';

final kLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: kFeuGreen,
).copyWith(
  primary: kFeuGreen,
  onPrimary: kWhite,
  secondary: kFeuYellow,
  onSecondary: kBlack,
  surface: kWhite,
  onSurface: kBlack,
  primaryContainer: kFeuGreen,
  onPrimaryContainer: kWhite,
  secondaryContainer: kYellowTint,
  onSecondaryContainer: kBlack,
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: kFeuGreen,
).copyWith(
  primary: kFeuGreen,
  onPrimary: kWhite,
  secondary: kFeuYellow,
  onSecondary: kBlack,
  surface: kDarkSurface,
  onSurface: kWhite,
  primaryContainer: kFeuGreen,
  onPrimaryContainer: kWhite,
  secondaryContainer: kDarkCard,
  onSecondaryContainer: kWhite,
);

final ThemeData kLightTheme = ThemeData().copyWith(
  colorScheme: kLightColorScheme,
  scaffoldBackgroundColor: kLightColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: kLightColorScheme.primaryContainer,
    foregroundColor: kLightColorScheme.onPrimaryContainer,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: kLightColorScheme.onPrimaryContainer,
    ),
  ),
  cardTheme: CardThemeData(
    color: kLightColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: kPagePadding,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kLightColorScheme.secondary,
      foregroundColor: kLightColorScheme.onSecondary,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: kLightColorScheme.onSecondaryContainer,
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: kLightColorScheme.onSecondaryContainer,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.normal,
      color: kLightColorScheme.onSecondaryContainer,
      fontSize: 15,
    ),
  ),
);

final ThemeData kDarkTheme = ThemeData.dark().copyWith(
  colorScheme: kDarkColorScheme,
  scaffoldBackgroundColor: kDarkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkColorScheme.primaryContainer,
    foregroundColor: kDarkColorScheme.onPrimaryContainer,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: kDarkColorScheme.onPrimaryContainer,
    ),
  ),
  cardTheme: CardThemeData(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(
      horizontal: kPagePadding,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.secondary,
      foregroundColor: kDarkColorScheme.onSecondary,
    ),
  ),
  textTheme: ThemeData.dark().textTheme.copyWith(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: kDarkColorScheme.onSecondaryContainer,
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: kDarkColorScheme.onSecondaryContainer,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.normal,
      color: kDarkColorScheme.onSecondaryContainer,
      fontSize: 15,
    ),
  ),
);