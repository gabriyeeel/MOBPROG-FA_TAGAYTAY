import 'package:flutter/material.dart';
import 'package:fa2_simple_quiz_app/commons/styled_button.dart';
import 'package:fa2_simple_quiz_app/commons/styled_text.dart';
import 'package:fa2_simple_quiz_app/data/questions_data.dart';
import 'package:fa2_simple_quiz_app/model/question.dart';
import 'package:fa2_simple_quiz_app/constants.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen(this.switchScreen, this.addPoint, {super.key});

  final void Function(String) switchScreen;
  final void Function() addPoint;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var questionIndex = 0;

  void answerPressed(String selectedAnswer) {
    Question currentQuestion = questionsData[questionIndex];

    if (selectedAnswer == currentQuestion.correctAnswer) {
      widget.addPoint();
    }

    if (questionIndex + 1 < questionsData.length) {
      setState(() {
        questionIndex = questionIndex + 1;
      });
    } else {
      widget.switchScreen('result-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questionsData[questionIndex];

    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: kSpacing,
          children: [
            StyledText(currentQuestion.text, kQuestionFontSize, color: Colors.white),
            ...currentQuestion.choices.map(
              (choice) => StyledButton(
                text: choice,
                onPressed: () {
                  answerPressed(choice);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}