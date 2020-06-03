import 'package:app/bloc/categories_bloc.dart';
import 'package:app/bloc/currentstate_bloc.dart';
import 'package:app/bloc/search_bloc.dart';
import 'package:app/generated/i18n.dart';
import 'package:app/interface/widget/article_list_element_collapsed.dart';
import 'package:app/interface/widget/article_slider_element.dart';
import 'package:app/interface/widget/category_list_element.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/currentstate_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final CurrentStateModel currentState;
  final FocusNode focusNode;

  const SearchPage({Key key, @required this.currentState, @required this.focusNode}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState(currentState: currentState);
}

class _SearchPageState extends State<SearchPage> {
  CurrentStateModel currentState;

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
    currentStateBloc.currentState.listen((onStateUpdate) => setState(() => currentState = onStateUpdate));

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
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<List<ArticleModel>>(
      stream: searchBloc.currentResults,
      // initialData: currentState.articles,
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> resultsSnapshot) => resultsSnapshot.hasData && state != SearchState.INACTIVE
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                // shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    ArticleListElementCollapsed(article: resultsSnapshot.data.elementAt(index), preferences: currentState.preferences),
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemCount: resultsSnapshot.data.length,
              ),
            )
          : state == SearchState.INACTIVE
              ? ListView(
                  children: <Widget>[
                    currentState.full
                        ? Padding(
                            padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 4.0),
                            child: AspectRatio(
                              aspectRatio: 7 / 5,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 7 / 5,
                                  viewportFraction: 1.0,
                                ),
                                items: currentState.articles
                                    .where((ArticleModel article) => article.featuredMediaUrl != null)
                                    .toList()
                                    .reversed
                                    .map((ArticleModel article) {
                                  debugPrint("Analizzo articolo.");
                                  return ArticleSliderElement(article: article, preferences: currentState.preferences);
                                }).toList(),
                              ),
                            ),
                          )
                        : Container(),
                    StreamBuilder<List<CategoryModel>>(
                      stream: categoriesBloc.allCategories,
                      builder: (BuildContext context, AsyncSnapshot<List<CategoryModel>> categoriesSnapshot) {
                        if (categoriesSnapshot.hasData)
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: categoriesSnapshot.data.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) => CategoryListElement(
                              category: categoriesSnapshot.data.elementAt(index),
                              preferences: currentState.preferences,
                            ),
                            separatorBuilder: (BuildContext context, int index) => Divider(height: 0.0, indent: 16.0, endIndent: 16.0),
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
