import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/resources/utility/preferences_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';

class ArticleDetailScreen extends StatefulWidget {
  static const String route = "/articleDetailScreen";

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  static ArticleDetailScreenRequest _request;

  @override
  Widget build(BuildContext context) {
    _request = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        // title: Text(title, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(preferredSize: Size(double.infinity, 0.0), child: Divider(height: 0.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _request.preferences.savedPosts.contains(_request.article.id) ? Icons.bookmark : Icons.bookmark_border,
              color: _request.preferences.savedPosts.contains(_request.article.id) ? Colors.redAccent : Colors.black,
            ),
            onPressed: () {
              if (_request.preferences.savedPosts.contains(_request.article.id)) {
                PreferencesHelper.unsavePost(_request.article, _request.preferences);
                _request.preferences.savedPosts.remove(_request.article.id);
              } else {
                PreferencesHelper.savePost(_request.article, _request.preferences);
                _request.preferences.savedPosts.add(_request.article.id);
              }
              setState(() {});
            },
          ),
          IconButton(icon: Icon(Icons.share), onPressed: () => Share.share(_request.article.link)),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    // return WebView(initialUrl: article.link,);

    return ListView(
      children: <Widget>[
        // Container(height: AppBar().preferredSize.height, child: References.appBar(context, "")),
        _request.article.featuredMediaUrl.isEmpty
            ? Container()
            : AspectRatio(
                aspectRatio: 7 / 5,
                child: CachedNetworkImage(
                  imageUrl: _request.article.featuredMediaUrl,
                  fit: BoxFit.cover,
                  placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
                ),
              ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(_request.article.title, style: Theme.of(context).textTheme.headline5),
              Divider(),
              Html(data: _request.article.htmlBody),
            ],
          ),
        ),
      ],
    );
  }
}

class ArticleDetailScreenRequest {
  final ArticleModel article;
  final PreferencesModel preferences;

  ArticleDetailScreenRequest({
    @required this.article,
    @required this.preferences,
  });
}
