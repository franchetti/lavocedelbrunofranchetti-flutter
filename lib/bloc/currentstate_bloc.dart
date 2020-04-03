import 'package:app/bloc/articles_bloc.dart';
import 'package:app/bloc/preferences_bloc.dart';
import 'package:app/models/currentstate_model.dart';
import 'package:rxdart/rxdart.dart';

class CurrentStateBloc {
  Stream<CurrentStateModel> get currentState =>
      Rx.combineLatest2(preferencesBloc.currentPreferences, articlesBloc.currentRange, (a, b) => CurrentStateModel(preferences: a, articles: b));

}

final CurrentStateBloc currentStateBloc = CurrentStateBloc();
