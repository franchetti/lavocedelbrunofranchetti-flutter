import 'package:app/models/settings_model.dart';
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

  void initialize(BuildContext context) {
    if (latestSettingsModel == null) {
      // Vedere se c'è uno stato salvato.
      if (false) {
      }
      // Se non c'è uno stato salvato...
      else {
        latestSettingsModel = SettingsModel();

        updateLocale(Localizations.localeOf(context));
        updateTheme(ThemeMode.system);

        lastLocale.listen((onLocaleChange) => updateVisualization());
        lastThemeMode.listen((onThemeChange) => updateVisualization());
      }
    }
  }

  String currentLocaleIso() {
    String currentLocaleIso =
        "${settingsBloc.latestSettingsModel.locale.languageCode}${settingsBloc.latestSettingsModel.locale.countryCode == null ? "" : "_${settingsBloc.latestSettingsModel.locale.countryCode}"}";

    return currentLocaleIso;
  }

  void updateLocale(Locale newLocale) {
    latestSettingsModel.locale = newLocale;
    _localeStream.sink.add(newLocale);
  }

  void updateTheme(ThemeMode themeMode) {
    latestSettingsModel.themeMode = themeMode;
    _themeModeStream.sink.add(themeMode);
  }

  void updateVisualization() {
    _settingsStream.sink.add(latestSettingsModel);
  }

  dispose() {
    _themeModeStream.close();
    _localeStream.close();
    _settingsStream.close();
  }
}

SettingsBloc settingsBloc = SettingsBloc();
