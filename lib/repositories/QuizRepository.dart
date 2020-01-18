import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:ff_quiz_app_flutter/models/Quiz.dart';

class QuizRepository {
  static Future<String> _loadJsonFile() async {
    return rootBundle.loadString('resources/datas/quizzez.json');
  }

  static Future<List<Quiz>> selectAll() async {
    List<Quiz> results = [];
    final result = await _loadJsonFile();
    final decoded = jsonDecode(result);
    decoded.forEach((json) => results.add(Quiz.fromJson(json)));
    return results;
  }

  static Future<Quiz> selectOne(final int index) async {
    List<Quiz> list = await selectAll();
    return list[index];
  }
}

