import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/quizviewmodel.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizViewModel = context.watch<QuizViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Score:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${quizViewModel.correctAnswers} / ${quizViewModel.questions.length}',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                quizViewModel.resetQuiz();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Play Again'),
            ),
            ElevatedButton(
              onPressed: () {
                quizViewModel.sendScore(quizViewModel.correctAnswers);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Save Score'),
            )
          ],
        ),
      ),
    );
  }
}
