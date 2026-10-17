import 'package:flutter/material.dart';
import 'package:fa2_simple_quiz_app/commons/styled_text.dart';
import 'package:fa2_simple_quiz_app/data/questions_data.dart';
import 'package:fa2_simple_quiz_app/constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.switchScreen, this.score, {super.key});

  final void Function(String) switchScreen;
  final int score;

  void restartButtonPressed() {
    switchScreen('start-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: kSpacing,
      children: [
        StyledText('Quiz Finished!', kTitleFontSize, color: Colors.white),

        StyledText(
          'You got $score out of ${questionsData.length} correct',
          kAnswerFontSize,
          color: Colors.white,
        ),

        SizedBox(height: 20),

        OutlinedButton.icon(
          onPressed: restartButtonPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
            backgroundColor: kButtonColor,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.refresh),
          label: StyledText('Restart', 15, color: Colors.white),
        ),
      ],
    );
  }
}