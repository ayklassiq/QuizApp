import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view/createquizpage.dart';
import 'package:quiz_app/view/leadership.dart';
import 'package:quiz_app/view/quizpage.dart';
import 'package:quiz_app/view/userCreateQuizPage.dart';

import '../service/authetication.dart';
import '../viewmodel/quizviewmodel.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final quizViewModel = Provider.of<QuizViewModel>(context);
    AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: quizViewModel.selectedCategory,
              hint: const Text('Select a category'),
              items: const [
                DropdownMenuItem(
                  value: '9',
                  child: Text('General Knowledge'),
                ),
                DropdownMenuItem(
                  value: '17',
                  child: Text('Science & Nature'),
                ),
                DropdownMenuItem(
                  value: '21',
                  child: Text('Sports'),
                ),
                DropdownMenuItem(
                  value: '23',
                  child: Text('History'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  quizViewModel.setSelectedCategory(value!);
                  quizViewModel.fetchQuestions();
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: quizViewModel.selectedCategory == null
                  ? null
                  : () async {
                      User? user = await authService.signInAnon();
                      if (user == null) {
                        print('Error signing in anonymously.');
                      } else {
                        print('Signed in anonymously.');
                      }
                      await quizViewModel.fetchQuestions();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => QuizScreen()));
                    },
              child: const Text('Start Quiz'),
            ),
            ElevatedButton(
              onPressed:  () async {
                // Navigator.pushNamed(context, '/quiz');
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx)=> LeaderboardScreen()));

              },
              child: const Text('Score Board'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CreateQuizScreen();
          })).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
