import 'package:app/models/article_model.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  static const String route = "/articleDetailScreen";

  static ArticleModel article;

  @override
  Widget build(BuildContext context) {
    article = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      // appBar: References.appBar(context, ""),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(height: AppBar().preferredSize.height, child: References.appBar(context, "")),
        Text(article.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(article.body, style: Theme.of(context).textTheme.bodyText2),
        ),
      ],
    );
  }
}
