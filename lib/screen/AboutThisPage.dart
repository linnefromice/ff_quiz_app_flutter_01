import 'package:flutter/material.dart';

class AboutThisPage extends StatelessWidget {

  static final String routeName = '/about_this';

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Fantasy Quiz App'),
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: Center(child: Text('ABOUT THIS')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About This',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: _buildHome(context),
    );
  }
}