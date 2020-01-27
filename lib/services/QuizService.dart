import 'package:ff_quiz_app_flutter/constants/Language.dart';
import 'package:ff_quiz_app_flutter/models/Quiz.dart';
import 'package:ff_quiz_app_flutter/repositories/QuizRepository.dart';

class QuizService {

  static Future<Quiz> selectRandomQuizWithoutUsed(
      final String lang, final List<int> usedIds) async {
    List<Quiz> list = await QuizRepository.selectAll(lang);
    list.shuffle();
    Quiz result;
    list.forEach((Quiz quiz) {
      if (!usedIds.contains(quiz.id)) {
        result = quiz;
      }
    });
    return result;
  }
}