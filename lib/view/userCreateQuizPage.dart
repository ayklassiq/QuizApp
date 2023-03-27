import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/useraddquizmodel.dart';
import '../service/database.dart';
import '../viewmodel/useraddquizviewmodel.dart';

class UserQuizScreen extends StatefulWidget {
  static const routeName = '/UserQuizScreen-screen';

  @override
  _UserQuizScreenState createState() => _UserQuizScreenState();
}

class _UserQuizScreenState extends State<UserQuizScreen> {
  late Future<List<Map<String, dynamic>>> _userQuizList;

  @override
  void initState() {
    super.initState();
    _userQuizList = MongoDatabase.getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final userquizViewModel = Provider.of<UserQuizViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Quiz List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _userQuizList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userQuizList = snapshot.data;
            return ListView.builder(
              itemCount: userQuizList?.length??0,
              itemBuilder: (context, index) {
                final userQuiz = UserQuiz.fromMap(userQuizList![index]);
                return Column(
                  children: [
                    Text(
                      'Question ${userquizViewModel.currentQuestionIndex + 1}/${userquizViewModel.questions.length}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    if (userquizViewModel.currentQuestionIndex <
                        userquizViewModel.questions.length)
                      Text(
                        userquizViewModel
                            .questions[userquizViewModel.currentQuestionIndex]
                            .userQuestion,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    SizedBox(height: 16),
                    ..._buildAnswerButtons(context, userquizViewModel.questions[userquizViewModel.currentQuestionIndex]),

                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

List<Widget> _buildAnswerButtons(BuildContext context, UserQuiz question) {
  final userquizViewModel = Provider.of<UserQuizViewModel>(context);

  final answerButtons = question.userIncorrectAnswers.map<Widget>((answer) {
    return ElevatedButton(
      onPressed: () => userquizViewModel.selectAnswer(answer, context),
      child: Text(answer),
    );
  }).toList();

  answerButtons.add(
    ElevatedButton(
      onPressed: () =>
          userquizViewModel.selectAnswer(question.userCorrectAnswer, context),
      child: Text(question.userCorrectAnswer),
    ),
  );

  answerButtons.shuffle();

  return answerButtons;
}
