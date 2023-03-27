
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:firebase_core/firebase_core.dart';
import '../model/useraddquizmodel.dart';
import '../service/database.dart';

class UserQuizViewModel extends ChangeNotifier {

  TextEditingController categoryController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();
  // List<TextEditingController> incorrectAnswersController = TextEditingController() as List<TextEditingController>;
  List<TextEditingController> incorrectAnswersController = List.generate(
    3, // set the number of incorrect answer fields to display
        (_) => TextEditingController(),
  );




  final formKey = GlobalKey<FormState>();
  //
  String? _userCategory = '';
  List<UserQuiz> _userQuestion = [];
  int _userCorrectAnswer = 0;
  List<String> _incorrectAnswers = [];
  int _currentQuestionIndex = 0;
  String? get selectedCategory => _userCategory;

  List<UserQuiz> get questions => _userQuestion;

  int get currentQuestionIndex => _currentQuestionIndex;

  int get correctAnswers => _userCorrectAnswer;


  void submitQuiz(context)async  {
    if (formKey.currentState!.validate()) {
      final user = UserQuiz(
        id: ObjectId(),
        userCategory: categoryController.text,
        userQuestion: questionController.text,
        userCorrectAnswer: correctAnswerController.text,
        userIncorrectAnswers: [
          incorrectAnswersController[0].text,
          incorrectAnswersController[1].text,
          incorrectAnswersController[2].text,

        ],
      );
      await MongoDatabase.insert(user);


      // TODO: save the new quiz to a MongoDB collection or any other data storage solution

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz created successfully!')),
      );
      notifyListeners();
    }
  }



  void selectAnswer(String selectedAnswer, BuildContext context) {
    final currentQuestion = _userQuestion[_currentQuestionIndex];
    if (selectedAnswer == currentQuestion.userCorrectAnswer) {
      _userCorrectAnswer++;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Correct!'),
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Wrong! The correct answer was ${currentQuestion.userCorrectAnswer}'),
        duration: Duration(seconds: 3),
      ));
    }

    _currentQuestionIndex++;

    if (_currentQuestionIndex == _userQuestion.length) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Quiz Complete'),
              content: Text('You got $_userCorrectAnswer out of ${_userQuestion
                  .length} questions correct.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }

    notifyListeners();
  }


}
