import 'package:app/models/article_model.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/preferences_model.dart';

class CurrentStateModel {
  List<ArticleModel> articles;
  PreferencesModel preferences;
  List<ArticleModel> saveds;
  List<CategoryModel> categories;
  bool full;

  CurrentStateModel({
    this.articles,
    this.preferences,
    this.saveds,
    this.categories,
    this.full,
  });
}
