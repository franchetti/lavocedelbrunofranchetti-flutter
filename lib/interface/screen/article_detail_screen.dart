import 'package:app/models/article_model.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
    // return WebView(initialUrl: article.link,);

    return ListView(
      children: <Widget>[
        Container(height: AppBar().preferredSize.height, child: References.appBar(context, "")),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(article.title, style: Theme.of(context).textTheme.headline5),
              Divider(),
              Html(data: article.htmlBody),
            ],
          ),
        ),
      ],
    );
  }
}
