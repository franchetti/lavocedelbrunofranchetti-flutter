import 'package:app/interface/screen/article_detail_screen.dart';
import 'package:app/models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticleListElement extends StatelessWidget {
  final ArticleModel article;
  final bool showImage;

  const ArticleListElement({Key key, @required this.article})
      : showImage = true,
        super(key: key);

  const ArticleListElement.reduced({Key key, @required this.article})
      : showImage = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Text(article.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5),
          Text(article.excerpt),
          article.featuredMediaUrl == null || !showImage
              ? Container()
              : Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 7 / 5,
                      child: CachedNetworkImage(
                        imageUrl: article.featuredMediaUrl,
                        fit: BoxFit.cover,
                        placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    article.featuredMediaCaption.isEmpty
                        ? Container()
                        : Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.0, top: 4.0),
                              child: Text(article.featuredMediaCaption, style: Theme.of(context).textTheme.caption),
                            ),
                          ),
                  ],
                ),
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed(ArticleDetailScreen.route, arguments: article),
    );
  }
}
