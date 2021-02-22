import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  static const String route = "/webViewScreen";

  String link;

  @override
  Widget build(BuildContext context) {
    if (link == null) link = ModalRoute.of(context).settings.arguments;
    // link = "https://google.it";

    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (link.toLowerCase().endsWith(".pdf")) {
      debugPrint("Usiamo il lettore di PDF di Google Drive.");
      link = "https://drive.google.com/viewerng/viewer?embedded=true&url=" + link;
    }

    return WebView(
      initialUrl: this.link,
      //debuggingEnabled: true,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
