import 'package:app/bloc/preferences_bloc.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/models/settings_model.dart';
import 'package:flutter/material.dart';
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

  static Future<void> setSettings(SettingsModel currentSettings) async {
    SharedPreferences sharedPreferences = (await SharedPreferences.getInstance());

    await sharedPreferences.setString("themeMode", currentSettings.themeMode.toString());
    await sharedPreferences.setString("language", currentSettings.locale.languageCode.toString());

    debugPrint("Salvate le impostazioni in memoria.");
  }

  static Future<SettingsModel> getSettings() async {
    SharedPreferences sharedPreferences = (await SharedPreferences.getInstance());
    SettingsModel settings = SettingsModel();

    String rawThemeMode = sharedPreferences.getString("themeMode");
    String rawLanguage = sharedPreferences.getString("language");

    switch (rawThemeMode) {
      case "ThemeMode.system":
        debugPrint("Il tema è di sistema.");
        settings.themeMode = ThemeMode.system;
        break;
      case "ThemeMode.light":
        debugPrint("Il tema è chiaro.");
        settings.themeMode = ThemeMode.light;
        break;
      case "ThemeMode.dark":
        debugPrint("Il tema è scuro.");
        settings.themeMode = ThemeMode.dark;
        break;
      default:
        debugPrint("Qualcosa non va con il tema.");
        settings.themeMode = ThemeMode.system;
        break;
    }

    switch (rawLanguage) {
      case "it":
        settings.locale = Locale.fromSubtags(languageCode: "it");
        break;
      case "en":
        settings.locale = Locale.fromSubtags(languageCode: "en");
        break;
      default:
        debugPrint("Qualcosa non va con la lingua.");
        settings.locale = Locale.fromSubtags(languageCode: "it");
        break;
    }

    return settings;
  }
}
