import 'package:flutter_wordpress/flutter_wordpress.dart';

class CategoryModel {
  final int id;
  final String name;

  /*String slug;
  String taxonomy;
  int parent;
  int count;
  String description;
  String link;*/

  CategoryModel({
    this.id,
    this.name,
  });

  factory CategoryModel.fromWordpressPost(Category wordpressCategory) => CategoryModel(
        id: wordpressCategory.id,
        name: wordpressCategory.name,
      );
}
