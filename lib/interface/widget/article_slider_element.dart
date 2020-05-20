import 'package:app/interface/screen/article_detail_screen.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleSliderElement extends StatelessWidget {
  final ArticleModel article;
  final PreferencesModel preferences;

  const ArticleSliderElement({Key key, @required this.article, @required this.preferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(ArticleDetailScreen.route, arguments: ArticleDetailScreenRequest(article: article, preferences: preferences)),
      child: AspectRatio(
        aspectRatio: 7 / 5,
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                child: CachedNetworkImage(
                  imageUrl: article.featuredMediaUrl,
                  fit: BoxFit.cover,
                  placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
                  child: Text(
                    article.title,
                    style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
