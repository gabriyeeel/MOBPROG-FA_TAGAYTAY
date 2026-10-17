import 'package:flutter/material.dart';
import 'package:fa2_simple_quiz_app/start_screen.dart';
import 'package:fa2_simple_quiz_app/question_screen.dart';
import 'package:fa2_simple_quiz_app/result_screen.dart';
import 'package:fa2_simple_quiz_app/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var activeScreen = 'start-screen';
  var score = 0;

  void switchScreen(String newScreen) {
    setState(() {
      activeScreen = newScreen;

      if (newScreen == 'start-screen') {
        score = 0;
      }
    });
  }

  void addPoint() {
    setState(() {
      score = score + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      currentScreen = QuestionScreen(switchScreen, addPoint);
    }

    if (activeScreen == 'result-screen') {
      currentScreen = ResultScreen(switchScreen, score);
    }

    return MaterialApp(
      title: 'Philippine Facts Quiz',
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: currentScreen,
        ),
      ),
    );
  }
}