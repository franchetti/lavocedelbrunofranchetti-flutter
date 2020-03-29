import 'package:app/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

class References {
  static AppBar appBar(BuildContext context, String title) => AppBar(
        title: Text(title, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(preferredSize: Size(double.infinity, 0.0), child: Divider(height: 0.0)),
      );

  static WordPress wordPress = WordPress(baseUrl: "https://www.traileoni.it/");

  static int articlesPerPage = 20;
}
