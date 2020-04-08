import 'package:app/models/settings_model.dart';
import 'package:app/resources/utility/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  final _themeModeStream = PublishSubject<ThemeMode>();
  final _localeStream = PublishSubject<Locale>();
  final _settingsStream = PublishSubject<SettingsModel>();

  Stream<ThemeMode> get lastThemeMode => _themeModeStream.stream;

  Stream<Locale> get lastLocale => _localeStream.stream;

  Stream<SettingsModel> get lastSettings => _settingsStream.stream;

  SettingsModel latestSettingsModel;

  Future<void> initialize(BuildContext context) async {
    if (latestSettingsModel == null) {
      // Vedere se c'è uno stato salvato.
      if (true) {
        latestSettingsModel = await PreferencesHelper.getSettings();
        updateVisualization();
      }
      // Se non c'è uno stato salvato...
      else {
        latestSettingsModel = SettingsModel();

        updateLocale(Localizations.localeOf(context));
        updateTheme(ThemeMode.system);
      }
      lastLocale.listen((onLocaleChange) => updateVisualization());
      lastThemeMode.listen((onThemeChange) => updateVisualization());
    }
  }

  String currentLocaleIso() {
    String currentLocaleIso =
        "${settingsBloc.latestSettingsModel.locale.languageCode}${settingsBloc.latestSettingsModel.locale.countryCode == null ? "" : "_${settingsBloc.latestSettingsModel.locale.countryCode}"}";

    return currentLocaleIso;
  }

  void updateLocale(Locale newLocale) {
    debugPrint("Aggiorno la lingua.");
    latestSettingsModel.locale = newLocale;
    _localeStream.sink.add(newLocale);
  }

  void updateTheme(ThemeMode themeMode) {
    debugPrint("Aggiorno il tema.");
    latestSettingsModel.themeMode = themeMode;
    _themeModeStream.sink.add(themeMode);
  }

  void updateVisualization() {
    debugPrint("Aggiorno le impostazioni nella visualizzazione.");
    _settingsStream.sink.add(latestSettingsModel);
    PreferencesHelper.setSettings(latestSettingsModel);
  }

  dispose() {
    _themeModeStream.close();
    _localeStream.close();
    _settingsStream.close();
  }
}

SettingsBloc settingsBloc = SettingsBloc();
