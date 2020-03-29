import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:html/parser.dart';

class ArticleListElement extends StatelessWidget {
  final Post article;

  const ArticleListElement({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(parse(article.title.rendered).documentElement.text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5),
        // Text(article.excerpt.rendered, style: Theme.of(context).textTheme.bodyText2),
        Text(parse(article.excerpt.rendered).documentElement.text),
        article.featuredMedia == null
            ? Container()
            : Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 7 / 5,
                    child: CachedNetworkImage(
                      imageUrl: article.featuredMedia.link,
                      fit: BoxFit.cover,
                      placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  article.featuredMedia.title.rendered.isEmpty
                      ? Container()
                      : Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: EdgeInsets.only(right: 4.0, top: 4.0),
                            child: Text(
                              article.featuredMedia.title.rendered,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                ],
              ),
      ],
    );
  }
}
