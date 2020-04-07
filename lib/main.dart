import 'package:app/generated/i18n.dart';
import 'package:app/interface/screen/article_detail_screen.dart';
import 'package:app/interface/screen/home_screen.dart';
import 'package:app/interface/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(TraiLeoni());

class TraiLeoni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Non è possibile tradurre questa stringa perché S non è ancora inizializzato.
      title: "Tra i leoni",
      theme: ThemeData(
        dividerTheme: DividerThemeData(thickness: 1.0),
        appBarTheme: AppBarTheme(color: Colors.white, iconTheme: IconThemeData(color: Colors.black)),
        primarySwatch: Colors.orange,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: SplashScreen(),
      routes: {
        HomeScreen.route: (BuildContext context) => HomeScreen(),
        ArticleDetailScreen.route: (BuildContext context) => ArticleDetailScreen(),
      },
    );
  }
}
