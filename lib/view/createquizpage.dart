import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/useraddquizmodel.dart';
import '../viewmodel/useraddquizviewmodel.dart';

class CreateQuizScreen extends StatefulWidget {
  static const routeName = '/createQuiz-screen';

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  // String category = '';
  // String question = '';
  // String correctAnswer = '';
  // List<String> incorrectAnswers = [];

  @override
  Widget build(BuildContext context) {
    final UserQuizViewModel _viewModel =
        Provider.of<UserQuizViewModel>(context, listen: true);

    final UserQuiz? user = ModalRoute.of(context)!.settings.arguments as UserQuiz?;
    if (user != null) {
      _viewModel.categoryController.text = user.userCategory;
      _viewModel.questionController.text = user.userQuestion;
      _viewModel.correctAnswerController.text = user.userCorrectAnswer;
      // _viewModel.incorrectAnswersController.text = user.userIncorrectAnswers as String;
      for (int i = 0; i < user.userIncorrectAnswers.length; i++) {
        _viewModel.incorrectAnswersController[i].text = user.userIncorrectAnswers[i];
      }

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Quiz'),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _viewModel.categoryController,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a category';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _viewModel.categoryController = value! as TextEditingController;
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _viewModel.questionController,

                        decoration: const InputDecoration(
                          labelText: 'Question',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a question';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _viewModel.questionController = value! as TextEditingController;
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _viewModel.correctAnswerController,

                        decoration: const InputDecoration(
                          labelText: 'Correct Answer',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a correct answer';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _viewModel.correctAnswerController = value! as TextEditingController;
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _viewModel.incorrectAnswersController[0],
                        decoration: const InputDecoration(
                          labelText: 'Incorrect Answer 1',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an incorrect answer';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _viewModel.incorrectAnswersController=value! as TextEditingController;
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _viewModel.incorrectAnswersController[1],
                        decoration: const InputDecoration(
                          labelText: 'Incorrect Answer 2',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an incorrect answer';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   _viewModel.incorrectAnswersController=value! as TextEditingController;
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _viewModel.incorrectAnswersController[2],

                        decoration: const InputDecoration(
                          labelText: 'Incorrect Answer 3',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an incorrect answer';
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   // _viewModel.incorrectAnswers.add(value!);
                        //   _viewModel.incorrectAnswersController=value! as TextEditingController;
                        //
                        // },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
                        child: ElevatedButton(
                          child: Text('Add Quiz'),
                          onPressed: () {
                            _viewModel.submitQuiz(context);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
