import 'dart:async';

import 'package:ff_quiz_app_flutter/main.dart';
import 'package:ff_quiz_app_flutter/models/Quiz.dart';
import 'package:ff_quiz_app_flutter/repositories/QuizRepository.dart';
import 'package:ff_quiz_app_flutter/screen/HomePage.dart';
import 'package:flutter/material.dart';
import './arguments/QuizPageArguments.dart';

class QuizPage extends StatefulWidget {
  static final String routeName = '/quiz';

  @override
  State<StatefulWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizPage> {

  final int CORRECT_ANSWERS_FOR_CLEAR = 5;
  int _numOfAnswers;

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

  Widget _buildAnswerButton(final int index, final Quiz quiz) => Container(
    padding: EdgeInsets.all(2.0),
    width: double.infinity,
    child: RaisedButton(
      child: Text(quiz.answerList[index], style: TextStyle(fontSize: 20.0),),
      onPressed: () {
        String _selectedAnswer = quiz.answerList[index];
        if (_selectedAnswer == quiz.correctAnswer) {
          _openCorrectDialog(_selectedAnswer, context);
          if (_numOfAnswers + 1 == CORRECT_ANSWERS_FOR_CLEAR) {
            Timer(Duration(seconds: 1), () {
              _openClearDialog(context);
            });
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(
                  context,
                  HomePage.routeName,
              );
            });
          } else {
            Timer(Duration(seconds: 1), () {
              Navigator.pushNamed(
                  context,
                  QuizPage.routeName,
                  arguments: QuizPageArguments(_numOfAnswers + 1)
              );
            });
          }
        } else {
          _openIncorrectDialog(_selectedAnswer, context);
          Timer(Duration(seconds: 1), () {
            Navigator.pushNamed(context, HomePage.routeName);
          });
        }
      }
    ),
  );

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
    });

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Quiz Page')),
        body: FutureBuilder<Quiz>(
          future: selectOne(_numOfAnswers),
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
                            alignment: Alignment.topRight,
                            child: Text("NUM OF CORRECT :" + _numOfAnswers.toString()),
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