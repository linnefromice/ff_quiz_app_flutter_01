import 'package:ff_quiz_app_flutter/screen/HomePage.dart';
import 'package:ff_quiz_app_flutter/screen/QuizListPage.dart';
import 'package:ff_quiz_app_flutter/screen/QuizPage.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final home = HomePage();
  static final routes = <String, WidgetBuilder>{
    HomePage.routeName : (context) => HomePage(),
    QuizPage.routeName : (context) => QuizPage(),
    QuizListPage.routeName : (context) => QuizListPage()
  };
}