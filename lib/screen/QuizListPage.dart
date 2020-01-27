import 'package:ff_quiz_app_flutter/constants/Language.dart';
import 'package:ff_quiz_app_flutter/models/Quiz.dart';
import 'package:ff_quiz_app_flutter/repositories/QuizRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizListPage extends StatefulWidget {
  static final String routeName = '/quizlist';

  @override
  State<StatefulWidget> createState() => _QuizListState();
}

class _QuizListState extends State<QuizListPage> {
  Future<List<Quiz>> _findQuizList() async {
    return await QuizRepository.selectAll(Language.JP);
  }

  Widget _buildRow(String title, String content) => Row(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          color: Colors.blueGrey,
          margin: EdgeInsets.all(1.0),
          child: Text(title),
        )
      ),
      Expanded(
          flex: 3,
          child: Container(
            color: Colors.grey,
            margin: EdgeInsets.all(1.0),
            child: Text(content),
          )
      )
    ],
  );

  Widget _buildCard(Quiz quiz) => Card(
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildRow('ID', quiz.id.toString()),
          _buildRow('QUESTION', quiz.questionText),
          _buildRow('OPTION1', quiz.answerList[0]),
          _buildRow('OPTION2', quiz.answerList[1]),
          _buildRow('OPTION3', quiz.answerList[2]),
          _buildRow('OPTION4', quiz.answerList[3]),
          /*
          ListView.builder(
              itemCount: quiz.answerList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildRow('OPTION' + index.toString(), quiz.answerList[index]);
              }
          ),
          */
          _buildRow('CORRECT', quiz.correctAnswer),
          /*
          */
        ],
      ),
    ),
  );

  Widget _buildCardList(final List<Quiz> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(12.0),
            child: _buildCard(list[index])
        );
      }
  );


  Widget _buildHome() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Fantasy Quiz App'),
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: _findQuizList(),
          builder: (BuildContext context, AsyncSnapshot<List<Quiz>> snapshot) {
            if (snapshot.hasData) {
              List<Quiz> list = snapshot.data;
              return _buildCardList(list);
            } else {
              return Text('NO DATA');
            }
          },
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizList',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: _buildHome(),
    );
  }
}
