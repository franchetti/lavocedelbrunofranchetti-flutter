import 'package:app/generated/i18n.dart';
import 'package:flutter/material.dart';

class References {
  static AppBar appBar(BuildContext context) => AppBar(
        title: Text(S.of(context).appName, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      );
}
