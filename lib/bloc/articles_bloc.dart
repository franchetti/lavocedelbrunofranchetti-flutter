import 'package:app/resources/repository.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:rxdart/rxdart.dart';

class ArticlesBloc {
  final _articlesFetcher = PublishSubject<List<Post>>();

  Stream<List<Post>> get currentRange => _articlesFetcher.stream;

  Future<List<Post>> getArticles(int page, int perPage) async {
    List<Post> articles = await Repository.getArticles(page, perPage);

    _articlesFetcher.sink.add(articles);

    return articles;
  }

  dispose() {
    _articlesFetcher.close();
  }
}

final ArticlesBloc articlesBloc = ArticlesBloc();
