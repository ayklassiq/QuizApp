import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/quiz_model.dart';
import '../viewmodel/quizviewmodel.dart';

class QuizScreen extends StatelessWidget {
  static const routeName = '/quiz -screen';
  @override
  Widget build(BuildContext context) {
    final quizViewModel = Provider.of<QuizViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: quizViewModel.questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${quizViewModel.currentQuestionIndex + 1}/${quizViewModel.questions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (quizViewModel.currentQuestionIndex < quizViewModel.questions.length)

              Text(
              quizViewModel.questions[quizViewModel.currentQuestionIndex].question,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._buildAnswerButtons(context, quizViewModel.questions[quizViewModel.currentQuestionIndex]),
          ],
        ),
      ),

    );
  }

  List<Widget> _buildAnswerButtons(BuildContext context, Question question) {
    final quizViewModel = Provider.of<QuizViewModel>(context);

    final answerButtons = question.incorrectAnswers.map<Widget>((answer) {
      return ElevatedButton(
        onPressed: () => quizViewModel.selectAnswer(answer, context),
        child: Text(answer),
      );
    }).toList();

    answerButtons.add(
      ElevatedButton(
        onPressed: () => quizViewModel.selectAnswer(question.correctAnswer, context),
        child: Text(question.correctAnswer),
      ),
    );

    answerButtons.shuffle();

    return answerButtons;
  }
 }
