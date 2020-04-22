import 'package:app/resources/utility/preferences_helper.dart';

class PreferencesModel {
  List<int> savedPosts;

  PreferencesModel({
    this.savedPosts,
  });

  Future<void> updatePreferences() async => await PreferencesHelper.updateSavedPosts(this.savedPosts);
}
