import 'package:app/bloc/currentstate_bloc.dart';
import 'package:app/generated/i18n.dart';
import 'package:app/interface/pages/articles_page.dart';
import 'package:app/interface/pages/saved_page.dart';
import 'package:app/interface/pages/search_page.dart';
import 'package:app/models/currentstate_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex;
  FocusNode focusNode;

  @override
  void initState() {
    currentIndex = 0;
    focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
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
    return StreamBuilder<CurrentStateModel>(
      stream: currentStateBloc.currentState,
      builder: (BuildContext context, AsyncSnapshot<CurrentStateModel> currentStateSnapshot) {
        debugPrint("Aggiorno la visualizzazione.");
        if (currentStateSnapshot.hasData)
          return IndexedStack(
            index: currentIndex,
            children: <Widget>[
              ArticlesPage(currentState: currentStateSnapshot.data),
              SearchPage(currentState: currentStateSnapshot.data, focusNode: focusNode),
              SavedPage(currentState: currentStateSnapshot.data),
            ],
          );

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int newIndex) {
        if (newIndex == 1)
          focusNode.requestFocus();
        else
          FocusScope.of(context).requestFocus(FocusNode());

        setState(() => currentIndex = newIndex);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.newspaper), title: Text(S.of(context).home)),
        BottomNavigationBarItem(icon: Icon(Icons.search), title: Text(S.of(context).search)),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), title: Text(S.of(context).saved)),
      ],
    );
  }
}
