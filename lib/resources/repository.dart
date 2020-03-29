import 'package:app/models/article_model.dart';
import 'package:app/resources/articles_provider.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class Repository {
  static Future<List<ArticleModel>> getArticles(int page, int perPage) async => ArticlesProvider.getArticles(page, perPage);
}