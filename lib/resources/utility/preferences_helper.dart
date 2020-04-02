import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static Future<void> updateSavedPosts(List<int> savedPosts) async => (await SharedPreferences.getInstance()).setStringList("saved", savedPosts.map((articleId) => articleId.toString()).toList());
}
