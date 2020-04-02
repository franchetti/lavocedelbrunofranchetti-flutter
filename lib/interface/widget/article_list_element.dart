import 'package:app/generated/i18n.dart';
import 'package:app/interface/screen/article_detail_screen.dart';
import 'package:app/models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticleListElement extends StatelessWidget {
  final ArticleModel article;
  final bool showImage;
  final bool isSaved;

  const ArticleListElement({Key key, @required this.article, @required this.isSaved})
      : showImage = true,
        super(key: key);

  const ArticleListElement.reduced({Key key, @required this.article, @required this.isSaved})
      : showImage = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: article.categories.length,
              // scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => Chip(
                    label: Text(article.categories.elementAt(index).name),
                    backgroundColor: Theme.of(context).primaryColor,
                  )),
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
      onLongPress: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) => ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ListTile(leading: Icon(Icons.bookmark_border), title: Text(S.of(context).saveForLater)),
              // TODO: Attivare.
              ListTile(leading: Icon(Icons.share), title: Text(S.of(context).saveForLater)),
            ],
          ),
        ),
      ),
    );
  }
}
