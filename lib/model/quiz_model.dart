  class Question {
    final String category;
    final String type;
    final String difficulty;
    final String question;
    final String correctAnswer;
    final List<String> incorrectAnswers;

    Question({
      required this.category,
      required this.type,
      required this.difficulty,
      required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers,
    });
  }