import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static Future<void> updateSavedPosts(List<String> savedPosts) async => (await SharedPreferences.getInstance()).setStringList("saved", savedPosts);
}
