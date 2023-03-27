import 'package:flutter/material.dart';
import '../model/useraddquizmodel.dart';
import '../service/database.dart';


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
              itemCount: userQuizList?.length,
              itemBuilder: (context, index) {
                final userQuiz = UserQuiz.fromMap(userQuizList![index]);
                return ListTile(
                  title: Text(userQuiz.userCategory),
                  subtitle: Text('Correct Answers: ${userQuiz.userCorrectAnswer}'),
                  trailing: Text('Incorrect Answers: ${userQuiz.userIncorrectAnswers}'),
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
