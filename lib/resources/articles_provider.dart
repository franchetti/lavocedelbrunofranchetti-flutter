import 'package:app/models/article_model.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class ArticlesProvider {
  static Future<List<ArticleModel>> getArticles(int page, int perPage) async {
    List<Post> rawArticles = await References.wordPress.fetchPosts(
      postParams: ParamsPostList(
        context: WordPressContext.view,
        pageNum: 1,
        perPage: 20,
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
}
