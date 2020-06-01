import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class References {
  static AppBar appBar(BuildContext context, String title) => AppBar(
        title: Text(title, style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? null : Colors.black)),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(preferredSize: Size(double.infinity, 0.0), child: Divider(height: 0.0)),
      );

  static WordPress wordPress = WordPress(baseUrl: "https://istitutobrunofranchetti.edu.it/giornalino/");

  static int articlesPerPage = 10;
}
