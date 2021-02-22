import 'dart:io';

import 'package:app/bloc/articles_bloc.dart';
import 'package:app/bloc/preferences_bloc.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/currentstate_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CurrentStateBloc {
  PublishSubject<CurrentStateModel> _currentStateFetcher = PublishSubject<CurrentStateModel>();

  Stream<CurrentStateModel> get currentState => _currentStateFetcher.stream;

  CurrentStateModel latestState;

  Future<CurrentStateModel> initialize() async {
    debugPrint("Inizializzo lo stato.");

    CurrentStateModel localCurrentState = CurrentStateModel();

    localCurrentState.articles = await articlesBloc.getArticles(1, References.articlesPerPage, full: false);
    localCurrentState.full = false;

    if (!(Platform.isLinux || Platform.isWindows || Platform.isMacOS))
      localCurrentState.preferences = await preferencesBloc.getPreferences();
    else
      localCurrentState.preferences = PreferencesModel(savedPosts: <int>[]);

    localCurrentState.saveds = await articlesBloc.getSaveds(localCurrentState.preferences);

    latestState = localCurrentState;

    _currentStateFetcher.sink.add(latestState);
    debugPrint("Aggiunto al sink dello stato.");

    preferencesBloc.currentPreferences.listen(updatePreferences);
    articlesBloc.savedPosts.listen(updateSaveds);
    articlesBloc.currentRange.listen(updateArticles);

    return localCurrentState;
  }

  CurrentStateModel updatePreferences(PreferencesModel preferences) {
    latestState.preferences = preferences;
    _currentStateFetcher.sink.add(latestState);

    articlesBloc.getSaveds(preferences);

    return latestState;
  }

  CurrentStateModel updateSaveds(List<ArticleModel> saveds) {
    latestState.saveds = saveds;
    _currentStateFetcher.sink.add(latestState);

    return latestState;
  }

  CurrentStateModel updateArticles(List<ArticleModel> articles) {
    latestState.articles = articles;
    _currentStateFetcher.sink.add(latestState);

    return latestState;
  }

  CurrentStateModel updateFullness(bool full) {
    latestState.full = full;
    _currentStateFetcher.add(latestState);

    debugPrint("Lo stato degli articoli è ora " + (full ? "completo" : "incompleto") + ".");

    return latestState;
  }

  dispose() {
    _currentStateFetcher.close();
  }
}

final CurrentStateBloc currentStateBloc = CurrentStateBloc();
