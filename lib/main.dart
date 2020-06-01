import 'package:app/bloc/settings_bloc.dart';
import 'package:app/generated/i18n.dart';
import 'package:app/interface/screen/article_detail_screen.dart';
import 'package:app/interface/screen/category_screen.dart';
import 'package:app/interface/screen/home_screen.dart';
import 'package:app/interface/screen/splash_screen.dart';
import 'package:app/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(lavocedelbrunofranchetti());

class lavocedelbrunofranchetti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsModel>(
      stream: settingsBloc.lastSettings,
      builder: (BuildContext context, AsyncSnapshot<SettingsModel> lastSettingsSnapshot) {
        return MaterialApp(
          // Non è possibile tradurre questa stringa perché S non è ancora inizializzato.
          title: "Tra i leoni",
          theme: ThemeData(
            dividerTheme: DividerThemeData(thickness: 1.0),
            appBarTheme: AppBarTheme(color: Colors.white, iconTheme: IconThemeData(color: Colors.black)),
            primarySwatch: Colors.orange,
          ),
          themeMode: lastSettingsSnapshot.hasData ? lastSettingsSnapshot.data.themeMode : ThemeMode.system,
          locale: lastSettingsSnapshot.hasData ? lastSettingsSnapshot.data.locale : null,
          darkTheme: ThemeData(primarySwatch: Colors.orange, accentColor: Colors.orange, brightness: Brightness.dark),
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
            CategoryScreen.route: (BuildContext context) => CategoryScreen(),
          },
        );
      },
    );
  }
}
