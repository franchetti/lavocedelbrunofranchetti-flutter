import 'package:app/generated/i18n.dart';
import 'package:app/interface/screen/article_detail_screen.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/resources/utility/preferences_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ArticleListElement extends StatelessWidget {
  final ArticleModel article;
  final bool showImage;
  final PreferencesModel preferences;

  const ArticleListElement({Key key, @required this.article, @required this.preferences})
      : showImage = true,
        super(key: key);

  const ArticleListElement.reduced({Key key, @required this.article, @required this.preferences})
      : showImage = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: preferences.savedPosts.contains(article.id)
                    ? Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Icon(Icons.bookmark, color: Colors.redAccent),
                      )
                    : Container(),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: article.categories.length,
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => Chip(
                        label: Text(article.categories.elementAt(index).name),
                        backgroundColor: Theme.of(context).primaryColor,
                      )),
            ],
          ),
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
      onTap: () =>
          Navigator.of(context).pushNamed(ArticleDetailScreen.route, arguments: ArticleDetailScreenRequest(article: article, preferences: preferences)),
      onLongPress: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) => ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.bookmark_border),
                title: Text(preferences.savedPosts.contains(article.id) ? S.of(context).unsave : S.of(context).saveForLater),
                onTap: () async {
                  if (preferences.savedPosts.contains(article.id))
                    PreferencesHelper.unsavePost(article, preferences);
                  else
                    PreferencesHelper.savePost(article, preferences);

                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text(S.of(context).shareThisArticle),
                onTap: () => Share.share(article.link),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
