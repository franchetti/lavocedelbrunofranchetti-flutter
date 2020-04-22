import 'package:app/models/category_model.dart';
import 'package:app/references.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class CategoriesProvider {
  static Future<List<CategoryModel>> getCategories() async {
    List<Category> rawCategories = await References.wordPress.fetchCategories(
      params: ParamsCategoryList(),
    );

    return rawCategories.map((Category rawCategory) => CategoryModel.fromWordpressCategory(rawCategory)).toList();
  }
}
