import 'package:app/interface/screen/category_screen.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/preferences_model.dart';
import 'package:flutter/material.dart';

class CategoryListElement extends StatelessWidget {
  final CategoryModel category;
  final PreferencesModel preferences;

  const CategoryListElement({Key key, @required this.category, @required this.preferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      trailing: Icon(Icons.chevron_right),
      onTap: () => Navigator.of(context).pushNamed(CategoryScreen.route, arguments: CategoryScreenRequest(category: category, preferences: preferences)),
    );
  }
}
