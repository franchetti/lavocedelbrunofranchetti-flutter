import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Tra i leoni";
  String get bocconiUniverisityNewspaper => "Bocconi University Newspaper";
  String get darkTheme => "Use dark theme";
  String get home => "Home";
  String get insertTextToSearch => "Insert your query...";
  String get noSaveds => "Your reading list is empty";
  String get readingList => "Reading list";
  String get saveForLater => "Add to reading list";
  String get saved => "Saved";
  String get search => "Find";
  String get shareThisArticle => "Share this article";
  String get systemTheme => "Use system theme";
  String get unsave => "Unsave this article";
}

class $en extends S {
  const $en();
}

class $it extends S {
  const $it();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get saved => "Salvati";
  @override
  String get systemTheme => "Utilizza impostazione di sistema";
  @override
  String get appName => "Tra i leoni";
  @override
  String get noSaveds => "La tua lista di lettura è vuota";
  @override
  String get darkTheme => "Utilizza il tema scuro";
  @override
  String get bocconiUniverisityNewspaper => "Bocconi University Newspaper";
  @override
  String get readingList => "Lista di lettura";
  @override
  String get home => "Home";
  @override
  String get search => "Cerca";
  @override
  String get shareThisArticle => "Condividi questo articolo";
  @override
  String get saveForLater => "Salva per dopo";
  @override
  String get unsave => "Rimuovi dalla lista di lettura";
  @override
  String get insertTextToSearch => "Inserisci del testo da cercare...";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("it", ""),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "it":
          S.current = const $it();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
