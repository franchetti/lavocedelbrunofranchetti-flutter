import 'package:app/models/preferences_model.dart';
import 'package:app/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PreferencesBloc {
  final _preferencesFetcher = PublishSubject<PreferencesModel>();

  Stream<PreferencesModel> get currentPreferences => _preferencesFetcher.stream;

  Future<PreferencesModel> getPreferences() async {
    PreferencesModel preferences = await Repository.getPreferences();

    _preferencesFetcher.sink.add(preferences);
    debugPrint("Aggiunto al sink delle preferenze.");

    return preferences;
  }

  dispose() {
    _preferencesFetcher.close();
  }
}

final PreferencesBloc preferencesBloc = PreferencesBloc();
