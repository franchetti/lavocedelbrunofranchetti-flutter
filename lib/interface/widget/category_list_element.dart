import 'package:app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryListElement extends StatelessWidget {
  final CategoryModel category;

  const CategoryListElement({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      trailing: Icon(Icons.chevron_right),
      onTap: (){},
    );
  }
}
