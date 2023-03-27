import 'package:mongo_dart/mongo_dart.dart';

class UserQuiz {
  final ObjectId id;
  final String userCategory;
  final String userCorrectAnswer;
  final String userQuestion;
  final List<String> userIncorrectAnswers;

  UserQuiz({
    required this.id,
    required this.userCategory,
    required this.userQuestion,
    required this.userCorrectAnswer,
    required this.userIncorrectAnswers,
  });

  // Convert a UserQuiz object to a map
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userCategory': userCategory,
      'userCorrectAnswer': userCorrectAnswer,
      'userQuestion': userQuestion,
      'userIncorrectAnswers': userIncorrectAnswers,
    };
  }

  // Create a UserQuiz object from a map
  static UserQuiz fromMap(Map<String, dynamic> map) {
    return UserQuiz(
      id: map['_id'],
      userCategory: map['userCategory'],
      userCorrectAnswer: map['userCorrectAnswer'],
      userQuestion: map['userQuestion'],
      userIncorrectAnswers: List<String>.from(map['userIncorrectAnswers']),
    );
  }
}
