import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  static const String route = "/webViewScreen";

  @override
  Widget build(BuildContext context) {
    String link = (ModalRoute.of(context).settings.arguments as String).replaceAll("http:", "https:");
    // link = "https://google.it";

    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context, link),
    );
  }

  Widget _buildBody(BuildContext context, String link) {
    if (link.toLowerCase().endsWith(".pdf")) if (Platform.isAndroid) {
      debugPrint("Usiamo il lettore di PDF di Google Drive.");
      link = "https://docs.google.com/gview?embedded=true&url=" + link;
    }

    debugPrint("Apro $link.");

    return WebView(
      // key: UniqueKey(),
      initialUrl: link,
      // debuggingEnabled: true,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
