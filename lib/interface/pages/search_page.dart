import 'package:app/bloc/search_bloc.dart';
import 'package:app/generated/i18n.dart';
import 'package:app/interface/widget/article_list_element_collapsed.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/currentstate_model.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final CurrentStateModel currentState;

  const SearchPage({Key key, @required this.currentState}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState(currentState: currentState);
}

class _SearchPageState extends State<SearchPage> {
  final CurrentStateModel currentState;

  _SearchPageState({@required this.currentState});

  static TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(labelText: S.of(context).insertTextToSearch),
          controller: _searchController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onSubmitted: (String query) => searchBloc.search(query),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<List<ArticleModel>>(
      stream: searchBloc.currentResults,
      initialData: currentState.articles,
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> resultsSnapshot) => resultsSnapshot.hasData
          ? ListView.separated(
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  ArticleListElementCollapsed(article: resultsSnapshot.data.elementAt(index), preferences: currentState.preferences),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: resultsSnapshot.data.length,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
