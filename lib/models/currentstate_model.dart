import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:flutter/material.dart';

class CurrentStateModel {
  List<ArticleModel> articles;
  PreferencesModel preferences;
  List<ArticleModel> saveds;

  CurrentStateModel({
     this.articles,
     this.preferences,
     this.saveds,
  });
}
