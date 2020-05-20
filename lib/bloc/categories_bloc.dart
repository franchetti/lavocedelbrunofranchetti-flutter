import 'package:app/models/category_model.dart';
import 'package:app/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesBloc {
  final _categoriesFetcher = PublishSubject<List<CategoryModel>>();

  Stream<List<CategoryModel>> get allCategories => _categoriesFetcher.stream;

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = await Repository.getCategories();

    _categoriesFetcher.sink.add(categories);
    debugPrint("Aggiunto al sink delle categorie.");

    return categories;
  }

  dispose() {
    _categoriesFetcher.close();
  }
}

final CategoriesBloc categoriesBloc = CategoriesBloc();
