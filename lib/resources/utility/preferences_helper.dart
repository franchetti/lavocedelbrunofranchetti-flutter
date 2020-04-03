import 'package:app/bloc/preferences_bloc.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static Future<void> updateSavedPosts(List<int> savedPosts) async =>
      (await SharedPreferences.getInstance()).setStringList("saved", savedPosts.map((articleId) => articleId.toString()).toList());

  static Future<void> savePost(ArticleModel post, PreferencesModel preferences) async {
    preferences.savedPosts.add(post.id);
    await preferences.updatePreferences();
    preferencesBloc.getPreferences();
  }

  static Future<void> unsavePost(ArticleModel post, PreferencesModel preferences) async {
    preferences.savedPosts.remove(post.id);
    await preferences.updatePreferences();
    preferencesBloc.getPreferences();
  }
}
