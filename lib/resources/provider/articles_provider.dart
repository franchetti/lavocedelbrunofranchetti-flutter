import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class ArticlesProvider {
  static Future<List<ArticleModel>> getArticles(int page, int perPage) async {
    List<Post> rawArticles = await References.wordPress.fetchPosts(
      postParams: ParamsPostList(
        context: WordPressContext.view,
        pageNum: page,
        perPage: perPage,
        order: Order.desc,
        orderBy: PostOrderBy.date,
      ),
      // fetchAuthor: true,
      fetchFeaturedMedia: true,
      // fetchComments: true,
      fetchCategories: true,
    );

    List<ArticleModel> articles = List<ArticleModel>();
    rawArticles.forEach((Post rawArticle) => articles.add(ArticleModel.fromWordpressPost(rawArticle)));

    debugPrint("Recuperati $perPage articoli.");
    return articles;
  }

  static Future<List<ArticleModel>> getSaveds(PreferencesModel preferences) async {
    if (preferences.savedPosts.isEmpty) {
      debugPrint("Non ci sono articoli salvati, restituisco vuoto.");
      return List<ArticleModel>();
    }
    debugPrint("Cerco gli articoli salvati: " + preferences.savedPosts.toString() + ".");

    List<Post> rawArticles = await References.wordPress.fetchPosts(postParams: ParamsPostList(includePostIDs: preferences.savedPosts), fetchFeaturedMedia: true);

    List<ArticleModel> articles = List<ArticleModel>();
    rawArticles.forEach((Post rawArticle) => articles.add(ArticleModel.fromWordpressPost(rawArticle)));

    debugPrint("Recuperati ${rawArticles.length} articoli salvati.");
    return articles;
  }
}
