import 'package:flutter/material.dart';
import 'constants.dart';
import 'profile_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.teal,
        body: const Center(
          child: ProfileCard(
            name: 'Gabriel L. Tagaytay',
            course: 'BS Applied Mathematics\n with Information Technology Track',
            bio: 'If that\'s the case, then pencil  case',
          ),
        ),
      ),
    );
  }
}