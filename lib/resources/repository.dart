import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/resources/provider/articles_provider.dart';
import 'package:app/resources/provider/preferences_provider.dart';

class Repository {
  static Future<List<ArticleModel>> getArticles(int page, int perPage) async => ArticlesProvider.getArticles(page, perPage);
  static Future<List<ArticleModel>> getSaveds(PreferencesModel preferences) async => ArticlesProvider.getSaveds(preferences);

  static Future<PreferencesModel> getPreferences() async => PreferencesProvider.getPreferences();
}
