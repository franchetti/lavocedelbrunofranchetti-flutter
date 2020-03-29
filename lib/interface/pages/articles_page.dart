import 'package:app/bloc/articles_bloc.dart';
import 'package:app/interface/widget/article_list_element.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class ArticlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    articlesBloc.getArticles(1, References.articlesPerPage);

    return StreamBuilder<List<Post>>(
      stream: articlesBloc.currentRange,
      builder: (BuildContext context, AsyncSnapshot<List<Post>> articlesSnapshot) {
        if (articlesSnapshot.hasData)
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) => ArticleListElement(article: articlesSnapshot.data.elementAt(index)),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              // TODO: Sostituire con il dato preconosciuto.
              itemCount: articlesSnapshot.data.length,
            ),
          );

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
