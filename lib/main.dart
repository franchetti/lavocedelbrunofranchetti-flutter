import 'package:app/generated/i18n.dart';
import 'package:app/interface/screen/home_screen.dart';
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

      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: HomeScreen(),
      routes: {
        HomeScreen.route: (BuildContext context) => HomeScreen(),
      },
    );
  }
}
