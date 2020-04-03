import 'package:app/generated/i18n.dart';
import 'package:app/interface/widget/article_list_element.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';

class ArticlesPage extends StatelessWidget {
  final PreferencesModel preferences;
  final List<ArticleModel> articles;

  ArticlesPage({
    @required this.preferences,
    @required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: References.appBar(context, S.of(context).appName),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => index.isEven
              ? ArticleListElement(article: articles.elementAt(index), preferences: preferences)
              : ArticleListElement.reduced(article: articles.elementAt(index), preferences: preferences),
          separatorBuilder: (BuildContext context, int index) => Divider(),
          // TODO: Sostituire con il dato preconosciuto.
          itemCount: articles.length,
        ),
      ),
    );
  }
}
