import 'package:fa3_my_reading_list_expdisthmcrt/books/books_screen.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Reading List',
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      themeMode: _themeMode,
      home: BooksScreen(toggleTheme: _toggleTheme),
    );
  }
}