class QuizPageArguments {

  final int numOfAnswers;
  final List<int> answeredQuizIds;
  final int correctAnswerForClear;
  final String language;

  QuizPageArguments(
    this.numOfAnswers,
    this.answeredQuizIds,
    this.correctAnswerForClear,
    this.language,
  );
}