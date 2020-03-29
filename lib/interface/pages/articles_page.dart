import 'package:app/bloc/articles_bloc.dart';
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
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) => Text(articlesSnapshot.data.elementAt(index).title.rendered),
            separatorBuilder: (BuildContext context, int index) => Container(),
            // TODO: Sostituire con il dato preconosciuto.
            itemCount: articlesSnapshot.data.length,
          );

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
