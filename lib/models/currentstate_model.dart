import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:flutter/material.dart';

class CurrentStateModel {
  final List<ArticleModel> articles;
  final PreferencesModel preferences;

  CurrentStateModel({
    @required this.articles,
    @required this.preferences,
  });
}
