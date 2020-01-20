import 'package:flutter/material.dart';

class AboutFFIXPage extends StatelessWidget {

  static final String routeName = '/about_ffix';

  Widget _buildReferenceElement() => _buildOneElement(
    'References',
    Container(
      padding: EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('https://www.jp.square-enix.com/ff9/'),
          Text('https://en.wikipedia.org/wiki/Final_Fantasy_IX'),
        ],
      ),
    ),
  );

  Widget _buildStoryElement() => _buildOneElement(
    'Story',
    Container(
        padding: EdgeInsets.all(2.0),
        child: Text('Final Fantasy IX takes place primarily on a world named Gaia. Most of Gaia\'s population reside on the Mist Continent, named after the thick Mist that blankets the lowlands. Large mountain ranges act as natural borders that separate its four nations: Alexandria, Lindblum, Burmecia, and Cleyra. Alexandria is a warmongering monarchy that controls the eastern half of the continent. One of its cities is Treno, a cultural nexus under perpetual starlight that is home to many aristocrats and paupers alike. The technologically advanced Lindblum, a hub of airship travel, is nestled on a plateau to the southwest. Both countries are populated by a mix of humans, humanoids, and anthropomorphic animals. Burmecia, a kingdom showered by endless rain, is in the northwest; Cleyra, a neighboring region that seceded from Burmecia due to the latter\'s appreciation for war, hails from a giant tree in the desert and is protected by a powerful sandstorm. Both are inhabited by anthropomorphic rats with a fondness for dance and spear fighting.')
    ),
  );

  Widget _buildOverviewElement() => _buildOneElement(
    'Overview',
    Container(
      padding: EdgeInsets.all(2.0),
      child: Text('Final Fantasy IX is a 2000 role-playing video game developed and published by Squaresoft for the PlayStation video game console. It is the ninth game in the main Final Fantasy series and the last to debut on the original PlayStation. The plot centers on the consequences of a war between nations in a medieval fantasy world called Gaia. Players follow bandit Zidane Tribal, who kidnaps Alexandrian princess Garnet Til Alexandros XVII as part of a gambit by the neighboring nation of Lindblum. He joins Garnet and a growing cast of characters on a quest to take down her mother, Queen Brahne of Alexandria, who started the war. The plot shifts when the player learns that Brahne is a pawn of a more menacing threat, Kuja, who shares a mysterious history with Zidane spanning two worlds.'),
    ),
  );

  Widget _buildElementTitle(final String title) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(4.0),
        child: Icon(
          Icons.label,
          color: Colors.white,
          size: 20.0,
        ),
      ),
      Container(
        padding: EdgeInsets.all(4.0),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    ],
  );

  Widget _buildOneElement(final String title, final Widget content) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(4.0),
        child: _buildElementTitle(title)
      ),
      Container(
        padding: EdgeInsets.all(4.0),
        child: content,
      ),
    ],
  );

  Widget _buildPageTitle() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(4.0),
        child: Icon(
          Icons.announcement,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      Container(
        padding: EdgeInsets.all(4.0),
        child: Text(
          'What is FFIX?',
          style: TextStyle(color: Colors.white, fontSize: 35.0),
        ),
      ),
    ],
  );

  Widget _buildPageContent(BuildContext context) => Stack(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('resources/images/aboutffix_top.jpg'),
            fit: BoxFit.cover,
          ),
        )
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color.fromRGBO(120, 120, 180, .8)),
      ),
      Container(
        padding: EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(4.0),
                child: _buildPageTitle(),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                child: _buildOverviewElement()
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                child: _buildStoryElement()
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                child: _buildReferenceElement()
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Fantasy Quiz App'),
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: Center(
        child: _buildPageContent(context)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About This',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: _buildScaffold(context),
    );
  }
}