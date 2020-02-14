import 'package:flutter/material.dart';
import 'routes/routes.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Fantasy Quiz App',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Routes.home,
      routes: Routes.routes,
    );
  }
}

