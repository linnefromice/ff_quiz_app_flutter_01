class QuizPageArguments {

  final int numOfAnswers;
  final List<int> answeredQuizIds;
  final int correctAnswerForClear;

  QuizPageArguments(
    this.numOfAnswers,
    this.answeredQuizIds,
    this.correctAnswerForClear
  );
}