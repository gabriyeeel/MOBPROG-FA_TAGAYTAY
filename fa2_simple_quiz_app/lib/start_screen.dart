import 'package:flutter/material.dart';
import 'package:fa2_simple_quiz_app/commons/styled_text.dart';
import 'package:fa2_simple_quiz_app/constants.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.switchScreen, {super.key});

  final void Function(String) switchScreen;

  void outlinedButtonPressed() {
    switchScreen('question-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Image.asset(
          'assets/philippine.png',
          width: 300,
          height: 300,
        ),

        SizedBox(height: 10),

        StyledText('Philippine Facts Quiz', kTitleFontSize, color: Colors.white),

        OutlinedButton.icon(
          onPressed: outlinedButtonPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
            backgroundColor: kButtonColor,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.play_arrow),
          label: StyledText('Start', 15, color: Colors.white),
        ),
      ],
    );
  }
}