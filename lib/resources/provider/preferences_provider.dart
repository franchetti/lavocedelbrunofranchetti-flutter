import 'package:app/models/preferences_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  static Future<PreferencesModel> getPreferences() async {
    PreferencesModel preferencesModel = PreferencesModel();

    preferencesModel.savedPosts = await getSavedPosts();

    return preferencesModel;
  }

  static Future<List<String>> getSavedPosts() async {
    List<String> savedPosts = (await SharedPreferences.getInstance()).getStringList("saved");

    if (savedPosts == null) return List<String>();
    return savedPosts;
  }
}
