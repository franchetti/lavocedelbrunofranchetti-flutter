import 'package:app/bloc/settings_bloc.dart';
import 'package:app/generated/i18n.dart';
import 'package:app/interface/screen/article_detail_screen.dart';
import 'package:app/interface/screen/category_screen.dart';
import 'package:app/interface/screen/home_screen.dart';
import 'package:app/interface/screen/splash_screen.dart';
import 'package:app/models/settings_model.dart';
import 'package:app/references.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(LaVoceDelBrunoFranchetti());

class LaVoceDelBrunoFranchetti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SettingsModel>(
      stream: settingsBloc.lastSettings,
      builder: (BuildContext context, AsyncSnapshot<SettingsModel> lastSettingsSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: References.appName,
          theme: ThemeData(
            dividerTheme: DividerThemeData(thickness: 1.0),
            appBarTheme: AppBarTheme(color: Colors.white, iconTheme: IconThemeData(color: Colors.black)),
            primarySwatch: Colors.teal,
            chipTheme: ChipThemeData.fromDefaults(primaryColor: Colors.teal, secondaryColor: Colors.teal, labelStyle: TextStyle(color: Colors.white)),
          ),
          themeMode: lastSettingsSnapshot.hasData ? lastSettingsSnapshot.data.themeMode : ThemeMode.system,
          locale: lastSettingsSnapshot.hasData ? lastSettingsSnapshot.data.locale : null,
          darkTheme: ThemeData(primarySwatch: Colors.teal, accentColor: Colors.teal, brightness: Brightness.dark),
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
