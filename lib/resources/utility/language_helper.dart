import 'package:app/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';

class LanguageHelper {
  // ignore: missing_return
  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case "it":
        return "Italiano";
        break;
      case "en":
        return "English";
        break;
    }
  }

  static bool isEnglish(BuildContext context) {
    bool isEnglish = ((settingsBloc.latestSettingsModel.locale != null && settingsBloc.latestSettingsModel.locale.languageCode != null)
                ? settingsBloc.latestSettingsModel.locale.languageCode
                : Localizations.localeOf(context).languageCode)
            .toUpperCase() ==
        "EN";
    debugPrint("Il testo " + (isEnglish ? "" : "non ") + "è inglese.");

    return isEnglish;
  }
}
