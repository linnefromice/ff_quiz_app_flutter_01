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
          title: Text('AboutThis'),
          onTap: () => Navigator.pushNamed(context, AboutThisPage.routeName)
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

  Widget _buildBody(BuildContext context) => Container(
    decoration: BoxDecoration(
      image: DecorationImage(
          image: _buildBackgroundImage(context),
          fit: BoxFit.fitWidth
      ),
    ),
    child: InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        QuizPage.routeName,
        arguments: QuizPageArguments(0)
      ),
      focusColor: Colors.blue,
      highlightColor: Colors.blue,
      hoverColor: Colors.blue,
      splashColor: Colors.blue,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              'QUIZ START',
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
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
    );
  }
}
