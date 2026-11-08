import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/screens/login_screen.dart';
import 'package:fa4_reverse_engineering/theme/app_theme.dart';
import 'package:fa4_reverse_engineering/theme/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.mode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Firefly',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: mode,
          home: const LoginScreen(),
        );
      },
    );
  }
}
