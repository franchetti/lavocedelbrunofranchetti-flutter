import 'package:app/models/article_model.dart';
import 'package:app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final _resultsFetcher = PublishSubject<List<ArticleModel>>();

  Stream<List<ArticleModel>> get currentResults => _resultsFetcher.stream;

  Future<List<ArticleModel>> search(String query) async {
    _resultsFetcher.sink.add(null);
    List<ArticleModel> results = await Repository.search(query);

    _resultsFetcher.sink.add(results);
    // debugPrint("Aggiunto al sink degli articoli.");

    return results;
  }

  dispose() {
    _resultsFetcher.close();
  }
}

final SearchBloc searchBloc = SearchBloc();
