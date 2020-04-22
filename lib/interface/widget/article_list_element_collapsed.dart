import 'package:app/generated/i18n.dart';
import 'package:app/interface/screen/article_detail_screen.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/resources/utility/preferences_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ArticleListElementCollapsed extends StatelessWidget {
  final ArticleModel article;
  final PreferencesModel preferences;

  const ArticleListElementCollapsed({Key key, @required this.article, @required this.preferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      leading: article.featuredMediaUrl == null
          ? null
          : AspectRatio(
              aspectRatio: 7 / 5,
              child: CachedNetworkImage(
                imageUrl: article.featuredMediaUrl,
                fit: BoxFit.cover,
                placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
              ),
            ),
      title: Text(article.title),
      subtitle: Text(
        article.excerpt,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
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
