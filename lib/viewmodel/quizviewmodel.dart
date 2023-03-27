// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/view/scorepage.dart';
import 'dart:convert';

import '../model/quiz_model.dart';
import '../model/useraddquizmodel.dart';
import '../view/createquizpage.dart';

class QuizViewModel extends ChangeNotifier {
  String? _selectedCategory;
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;

  String? get selectedCategory => _selectedCategory;

  List<Question> get questions => _questions;

  int get currentQuestionIndex => _currentQuestionIndex;

  int get correctAnswers => _correctAnswers;
  List<UserQuiz> _userQuizzes = [];

  List<UserQuiz> get userQuizzes => _userQuizzes;

  void createQuiz(UserQuiz quiz) {
    _userQuizzes.add(quiz);
    notifyListeners();
  }

// Get the device token
//   Future<String?> deviceToken =  FirebaseMessaging.instance.getToken();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  void setSelectedCategory(String category) {
    _selectedCategory = category;
  }
  void submitScore( int score,) {
    FirebaseFirestore.instance
        .collection('users')
        .add({
      // 'name': userId,
      'score': score,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
void sendScore(int score) {
  firestore.collection('users').add({
    // 'name': 'John Doe',
    'score': score,
    'timestamp': FieldValue.serverTimestamp(),
  }).then((value) {
    print('Document added with ID: ${value.id}');
  }).catchError((error) {
    print('Error adding document: $error');
  });
}
  //Create a new "users" collection in Firestore
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  //Update the user's score in Firestore whenever they complete a quiz:
  void updateUserScore(String userId, int score) {
    usersCollection.doc(userId).set({'score': score}, SetOptions(merge: true));
  }


  // fetch question from API
  Future<void> fetchQuestions() async {
    final url = Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=$_selectedCategory&type=multiple');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final results = responseData['results'];
      _questions = results.map<Question>((questionData) {
        final incorrectAnswers = List<String>.from(
            questionData['incorrect_answers']);
        return Question(
          category: questionData['category'],
          type: questionData['type'],
          difficulty: questionData['difficulty'],
          question: questionData['question'],
          correctAnswer: questionData['correct_answer'],
          incorrectAnswers: incorrectAnswers,
        );
      }).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void selectAnswer(String selectedAnswer, BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    if (selectedAnswer == currentQuestion.correctAnswer) {
      _correctAnswers++;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Correct!'),
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Wrong! The correct answer was ${currentQuestion.correctAnswer}'),
        duration: const Duration(seconds: 3),
      ));
    }

    if (_currentQuestionIndex == _questions.length-1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return ScoreScreen();
          }));      // showDialog(
      //   context: context,
      //   builder: (context) =>
      //       AlertDialog(
      //         title: const Text('Quiz Complete'),
      //         content: Text('You got $_correctAnswers out of ${_questions
      //             .length} questions correct.'),
      //         actions: [
      //           TextButton(
      //             onPressed: () => Navigator.pop(context),
      //             child: const Text('OK'),
      //           ),
      //         ],
      //       ),
      // );
    }else{
      _currentQuestionIndex++;

    }

    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex
    = 0;
    _correctAnswers = 0;
    _questions = [];
    notifyListeners();
  }
}