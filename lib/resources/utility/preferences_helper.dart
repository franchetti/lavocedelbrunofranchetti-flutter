import 'package:app/bloc/preferences_bloc.dart';
import 'package:app/models/preferences_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static Future<void> updateSavedPosts(List<int> savedPosts) async =>
      (await SharedPreferences.getInstance()).setStringList("saved", savedPosts.map((articleId) => articleId.toString()).toList());

  static Future<void> savePost(int postId, PreferencesModel preferences) async {
    preferences.savedPosts.add(postId);
    await preferences.updatePreferences();
    preferencesBloc.getPreferences();
  }

  static Future<void> unsavePost(int postId, PreferencesModel preferences) async {
    preferences.savedPosts.remove(postId);
    await preferences.updatePreferences();
    preferencesBloc.getPreferences();
  }
}
