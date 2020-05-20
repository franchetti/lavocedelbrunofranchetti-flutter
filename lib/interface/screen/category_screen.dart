import 'package:app/bloc/articles_bloc.dart';
import 'package:app/interface/widget/article_list_element_collapsed.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static const String route = "/categoryScreen";

  CategoryScreenRequest _request;

  @override
  Widget build(BuildContext context) {
    _request = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_request.category.name),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    articlesBloc.getArticlesByCategory(_request.category);

    return StreamBuilder<List<ArticleModel>>(
      stream: articlesBloc.byCategory,
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> articlesByCategorySnapshot) {
        if (articlesByCategorySnapshot.hasData)
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.separated(
              itemCount: articlesByCategorySnapshot.data.length,
              itemBuilder: (BuildContext context, int index) =>
                  ArticleListElementCollapsed(article: articlesByCategorySnapshot.data.elementAt(index), preferences: _request.preferences),
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          );

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class CategoryScreenRequest {
  final CategoryModel category;
  final PreferencesModel preferences;

  CategoryScreenRequest({
    @required this.category,
    @required this.preferences,
  });
}
