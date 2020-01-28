import 'dart:async';

import 'package:ff_quiz_app_flutter/constants/Language.dart';
import 'package:ff_quiz_app_flutter/models/Quiz.dart';
import 'package:ff_quiz_app_flutter/screen/HomePage.dart';
import 'package:ff_quiz_app_flutter/services/QuizService.dart';
import 'package:flutter/material.dart';
import './arguments/QuizPageArguments.dart';

class QuizPage extends StatefulWidget {
  static final String routeName = '/quiz';

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizPage> {

  // TODO: BLOCを利用
  int _correctAnswerForClear;
  int _numOfAnswers;
  List<int> _answeredQuizIds;
  String _language;

  Widget _buildClearDialog() => SimpleDialog(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        child: Text('Game Clear'),
      ),
      Icon(
        Icons.thumb_up,
        size: 100,
        color: Colors.yellow,
      ),
      Container(
        alignment: Alignment.center,
        child: Text('Congratulation!!'),
      ),
    ],
  );

  Future _openClearDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildClearDialog();
        }
    );
  }

  Widget _buildCorrectDialog(final String answer) => SimpleDialog(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        child: Text('CORRECT'),
      ),
      Icon(
        Icons.check_circle,
        size: 100,
        color: Colors.green,
      ),
      Container(
        alignment: Alignment.center,
        child: Text(answer),
      ),
    ],
  );

  Future _openCorrectDialog(final String answer, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildCorrectDialog(answer);
        }
    );
  }

  Widget _buildIncorrectDialog(final String answer) => SimpleDialog(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        child: Text("INCORRECT"),
      ),
      Icon(
        Icons.close,
        size: 100,
        color: Colors.red,
      ),
      Container(
        alignment: Alignment.center,
        child: Text(answer),
      ),
    ],
  );

  Future _openIncorrectDialog(final String answer, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildIncorrectDialog(answer);
        }
    );
  }

  void executeForNextQuiz(final int quizId) {
    _answeredQuizIds.add(quizId);
    Timer(Duration(seconds: 1), () {
      Navigator.pushNamed(
        context,
        QuizPage.routeName,
        arguments: QuizPageArguments(
            _numOfAnswers + 1,
          _answeredQuizIds,
          _correctAnswerForClear,
          _language,
        ),
      );
    });
  }

  void executeClear() {
    Timer(Duration(seconds: 1), () {
      _openClearDialog(context);
    });
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(
        context,
        HomePage.routeName,
      );
    });
  }

  void executeCorrect(final String selectedAnswer, final int quizId) {
    _openCorrectDialog(selectedAnswer, context);
    if (_numOfAnswers + 1 == _correctAnswerForClear) {
      executeClear();
    } else {
      executeForNextQuiz(quizId);
    }
  }

  void clickAnswer(final String selectedAnswer, final Quiz quiz) {
    if (selectedAnswer == quiz.correctAnswer) {
      executeCorrect(selectedAnswer, quiz.id);
    } else {
      _openIncorrectDialog(selectedAnswer, context);
      Timer(Duration(seconds: 1), () {
        Navigator.pushNamed(context, HomePage.routeName);
      });
    }
  }

  Widget _buildAnswerButton(final int index, final Quiz quiz) => Container(
    padding: EdgeInsets.all(2.0),
    width: double.infinity,
    child: RaisedButton(
      child: Text(quiz.answerList[index], style: TextStyle(fontSize: 20.0),),
      onPressed: () => clickAnswer(quiz.answerList[index], quiz)
    ),
  );

  // ignore: unused_element
  Widget _buildAnswerButtonList(final Quiz quiz) => ListView.builder(
    itemCount: quiz.answerList.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildAnswerButton(index, quiz);
    },
  );

  @override
  Widget build(BuildContext context) {
    final QuizPageArguments _args = ModalRoute.of(context).settings.arguments;
    setState(() {
      _numOfAnswers = _args.numOfAnswers;
      _answeredQuizIds = _args.answeredQuizIds;
      _correctAnswerForClear = _args.correctAnswerForClear;
      _language = _args.language;
    });

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Page'),
          centerTitle: true,
          leading: IconButton(icon:Icon(Icons.close),
            onPressed:() => Navigator.pushNamed(context, HomePage.routeName),
          ),
        ),
        body: FutureBuilder<Quiz>(
          future: QuizService.selectRandomQuizWithoutUsed(_language, _answeredQuizIds),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Quiz _data = snapshot.data;
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.grey
                                  ),
                                  child: Text('NUM OF CORRECT'),
                                ),
                                Container(
                                  padding: EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.grey
                                  ),
                                  child: Text(
                                    '${_numOfAnswers.toString()} / ${_correctAnswerForClear.toString()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.device_unknown,
                              size: 50,
                            ),
                          ),
                          Container(
                            child: Text(
                              _data.questionText,
                              style: TextStyle(
                                fontSize: 20.0
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // TODO: 繰り返しで記述
                    _buildAnswerButton(0, _data),
                    _buildAnswerButton(1, _data),
                    _buildAnswerButton(2, _data),
                    _buildAnswerButton(3, _data),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('ERROR');
            } else {
              return Text('LOADING...');
            }
          }
        )
      ),
    );
  }
}