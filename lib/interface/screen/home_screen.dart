import 'package:app/generated/i18n.dart';
import 'package:app/interface/pages/articles_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex;

  ArticlesPage articlesPage;

  @override
  void initState() {
    currentIndex = 0;

    articlesPage = ArticlesPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: References.appBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: <Widget>[articlesPage, Container(), Container()],
    );

    <Widget>[
      articlesPage,
      Container(),
      Container(),
    ].elementAt(currentIndex);
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int newIndex) => setState(() => currentIndex = newIndex),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.newspaper), title: Text(S.of(context).home)),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), title: Text(S.of(context).saved)),
        BottomNavigationBarItem(icon: Icon(Icons.android), title: Text(S.of(context).home)),
      ],
    );
  }
}
