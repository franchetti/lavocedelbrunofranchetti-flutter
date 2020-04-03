import 'package:app/bloc/preferences_bloc.dart';
import 'package:app/models/article_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:app/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ArticlesBloc {
  final _articlesFetcher = PublishSubject<List<ArticleModel>>();
  final _savedsFetcher = PublishSubject<List<ArticleModel>>();

  Stream<List<ArticleModel>> get currentRange => _articlesFetcher.stream;

  Stream<List<ArticleModel>> get savedPosts => _savedsFetcher.stream;

  Future<List<ArticleModel>> getArticles(int page, int perPage) async {
    List<ArticleModel> articles = await Repository.getArticles(page, perPage);

    _articlesFetcher.sink.add(articles);
    debugPrint("Aggiunto al sink degli articoli.");

    return articles;
  }

  Future<List<ArticleModel>> getSaveds(PreferencesModel preferences) async {
    List<ArticleModel> saveds = await Repository.getSaveds(preferences);

    _savedsFetcher.sink.add(saveds);
    debugPrint("Aggiunto al sink dei salvati.");

    return saveds;
  }

  dispose() {
    _articlesFetcher.close();
    _savedsFetcher.close();
  }
}

final ArticlesBloc articlesBloc = ArticlesBloc();
