import 'package:app/bloc/categories_bloc.dart';
import 'package:app/bloc/search_bloc.dart';
import 'package:app/generated/i18n.dart';
import 'package:app/interface/widget/article_list_element_collapsed.dart';
import 'package:app/interface/widget/category_list_element.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/currentstate_model.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final CurrentStateModel currentState;
  final FocusNode focusNode;

  const SearchPage({Key key, @required this.currentState, @required this.focusNode}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState(currentState: currentState);
}

class _SearchPageState extends State<SearchPage> {
  final CurrentStateModel currentState;

  _SearchPageState({@required this.currentState});

  static TextEditingController _searchController;

  SearchState state;

  @override
  void initState() {
    _searchController = TextEditingController();
    state = SearchState.INACTIVE;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: S.of(context).insertTextToSearch),
                controller: _searchController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (String query) {
                  searchBloc.search(query);
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() => state = SearchState.SEARCHING);
                },
                focusNode: widget.focusNode,
              ),
            ),
            IconButton(
              icon: Icon(Icons.backspace, color: Theme.of(context).accentColor),
              onPressed: () {
                searchBloc.search("");
                _searchController.clear();
                setState(() => state = SearchState.INACTIVE);
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
          ],
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
      // initialData: currentState.articles,
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> resultsSnapshot) => resultsSnapshot.hasData && state != SearchState.INACTIVE
          ? ListView.separated(
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  ArticleListElementCollapsed(article: resultsSnapshot.data.elementAt(index), preferences: currentState.preferences),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: resultsSnapshot.data.length,
            )
          : state == SearchState.INACTIVE
              ? ListView(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                    StreamBuilder<List<CategoryModel>>(
                      stream: categoriesBloc.allCategories,
                      builder: (BuildContext context, AsyncSnapshot<List<CategoryModel>> categoriesSnapshot) {
                        if (categoriesSnapshot.hasData)
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: categoriesSnapshot.data.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) => CategoryListElement(category: categoriesSnapshot.data.elementAt(index)),
                            separatorBuilder: (BuildContext context, int index) => Divider(height: 0.0),
                          );

                        categoriesBloc.getCategories();
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
    );
  }
}

enum SearchState { SEARCHING, FOUND, INACTIVE }
