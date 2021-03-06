import 'package:ff_quiz_app_flutter/constants/Language.dart';
import 'package:ff_quiz_app_flutter/screen/AboutFFIXPage.dart';
import 'package:ff_quiz_app_flutter/screen/AboutThisPage.dart';
import 'package:ff_quiz_app_flutter/screen/QuizListPage.dart';
import 'package:ff_quiz_app_flutter/screen/arguments/QuizPageArguments.dart';
import 'package:flutter/material.dart';

import 'QuizPage.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home';

  HomePage({Key key}) : super(key: key);

  Widget _buildAppBar() => AppBar(
    title: Text('Final Fantasy Quiz App'),
    centerTitle: true,
  );

  Widget _buildDrawer(BuildContext context) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Colors.white]
              ),
            ),
            child: Text(
              'Navigation Menu',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
              ),
            ),
          ),
        ),
        ListTile(
          title: Text('About This'),
          onTap: () => Navigator.pushNamed(context, AboutThisPage.routeName)
        ),
        ListTile(
          title: Text('About FFIX'),
          onTap: () => Navigator.pushNamed(context, AboutFFIXPage.routeName)
        ),
        ListTile(
          title: Text('QuizList'),
          onTap: () => Navigator.pushNamed(context, QuizListPage.routeName)
        ),
      ],
    ),
  );

  AssetImage _buildBackgroundImage(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return AssetImage('resources/images/home_vertical.jpg');
    } else {
      return AssetImage('resources/images/home_horizon.jpg');
    }
  }

  Widget _buildStartTitle() => Column(
    children: <Widget>[
      Text(
        'Final Fantasy IX',
        style: TextStyle(
          fontSize: 40.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 1.0,
              color: Colors.white
            ),
          ]
        ),
      ),
      Text(
        'QUIZ',
        style: TextStyle(
          fontSize: 40.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 1.0,
              color: Colors.white
            ),
          ]
        ),
      ),
    ],
  );

  Widget _buildStartButtonForEasy(BuildContext context, String language) => _buildStartButton(
    context,
    Icons.filter_3,
    Colors.white,
    'Easy',
    Colors.green,
    3,
    language
  );

  Widget _buildStartButtonForNormal(BuildContext context, String language) => _buildStartButton(
    context,
    Icons.filter_5,
    Colors.white,
    'Normal',
    Colors.grey,
    5,
    language
  );

  Widget _buildStartButtonForHard(BuildContext context, String language) => _buildStartButton(
    context,
    Icons.filter_9_plus,
    Colors.white,
    'Hard',
    Colors.red,
    10,
    language
  );

  Widget _buildStartButton(
    BuildContext context,
    IconData _icon,
    Color _iconColor,
    String _msg,
    Color _buttonColor,
    int _correctAnswerForClear,
    String _language,
  ) => RaisedButton.icon(
    icon: Icon(
      _icon,
      color: _iconColor,
    ),
    label: Text(
      _msg,
      style: TextStyle(fontSize: 16),
    ),
    color: _buttonColor,
    onPressed: () => Navigator.pushNamed(
      context,
      QuizPage.routeName,
      arguments: QuizPageArguments(0, [], _correctAnswerForClear, _language)
    ),
  );

  Widget _buildStartButtons(BuildContext context, String language, Size size) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(2.0),
        width: size.width * 0.33,
        child: _buildStartButtonForEasy(context, language)
      ),
      Container(
        padding: EdgeInsets.all(2.0),
        width: size.width * 0.33,
        child: _buildStartButtonForNormal(context, language)
      ),
      Container(
        padding: EdgeInsets.all(2.0),
        width: size.width * 0.33,
        child: _buildStartButtonForHard(context, language)
      ),
    ],
  );

  Widget _buildBody(BuildContext context, size) => Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: _buildBackgroundImage(context),
        fit: BoxFit.fitWidth
      ),
    ),
    child: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildStartTitle(),
          Text(
            'English Version',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: size.width,
            child: _buildStartButtons(context, Language.EN, size),
          ),
          Text(
            'Japanese Version',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: size.width,
            child: _buildStartButtons(context, Language.JP, size),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context),
      body: _buildBody(context, size),
    );
  }
}
