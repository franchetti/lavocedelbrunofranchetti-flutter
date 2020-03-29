import 'package:app/resources/articles_provider.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class Repository {
  static Future<List<Post>> getArticles(int page, int perPage) async => ArticlesProvider.getArticles(page, perPage);
}