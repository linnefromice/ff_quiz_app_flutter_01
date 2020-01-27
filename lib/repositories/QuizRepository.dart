import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:ff_quiz_app_flutter/models/Quiz.dart';

class QuizRepository {
  static Future<String> _loadJsonFile(final String lang) async {
    switch (lang) {
      case 'en':
        return rootBundle.loadString('resources/datas/en/quizzez.json');
      case 'jp':
        return rootBundle.loadString('resources/datas/jp/quizzez.json');
      default:
        return rootBundle.loadString('resources/datas/en/quizzez.json');
    }
  }

  static Future<List<Quiz>> selectAll(final String lang) async {
    List<Quiz> results = [];
    final result = await _loadJsonFile(lang);
    final decoded = jsonDecode(result);
    decoded.forEach((json) => results.add(Quiz.fromJson(json)));
    return results;
  }

  static Future<Quiz> selectOne(final String lang, final int index) async {
    List<Quiz> list = await selectAll(lang);
    return list[index];
  }
}

