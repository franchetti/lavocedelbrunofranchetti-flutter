import 'package:app/models/article_model.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class SearchProvider {
  static Future<List<ArticleModel>> search(String query) async {
    List<Post> rawArticles = await References.wordPress.fetchPosts(
      postParams: ParamsPostList(
        context: WordPressContext.view,
        order: Order.desc,
        orderBy: PostOrderBy.date,
        searchQuery: query,
      ),
      // fetchAuthor: true,
      fetchFeaturedMedia: true,
      // fetchComments: true,
      fetchCategories: true,
    );

    List<ArticleModel> articles = List<ArticleModel>();
    rawArticles.forEach((Post rawArticle) => articles.add(ArticleModel.fromWordpressPost(rawArticle)));

    debugPrint("Recuperati ${articles.length} articoli con la query $query.");
    return articles;
  }
}
