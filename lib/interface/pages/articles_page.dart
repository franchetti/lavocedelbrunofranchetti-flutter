import 'package:app/assets.dart';
import 'package:app/interface/widget/article_list_element.dart';
import 'package:app/models/currentstate_model.dart';
import 'package:flutter/material.dart';

class ArticlesPage extends StatelessWidget {
  final CurrentStateModel currentState;

  const ArticlesPage({Key key, @required this.currentState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(image: Theme.of(context).brightness == Brightness.dark ? Images.icExtendedDark : Images.icExtended, fit: BoxFit.fitHeight, height: 40.0),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => index.isEven
              ? ArticleListElement(article: currentState.articles.elementAt(index), preferences: currentState.preferences)
              : ArticleListElement.reduced(article: currentState.articles.elementAt(index), preferences: currentState.preferences),
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: currentState.articles.length,
        ),
      ),
    );
  }
}
