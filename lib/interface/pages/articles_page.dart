import 'package:app/assets.dart';
import 'package:app/bloc/settings_bloc.dart';
import 'package:app/generated/i18n.dart';
import 'package:app/interface/widget/article_list_element.dart';
import 'package:app/models/currentstate_model.dart';
import 'package:app/resources/utility/language_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_pickers/language_picker_dropdown.dart';
import 'package:language_pickers/languages.dart';

class ArticlesPage extends StatelessWidget {
  final CurrentStateModel currentState;

  const ArticlesPage({Key key, @required this.currentState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(image: Theme.of(context).brightness == Brightness.dark ? Images.logoLight : Images.logoDark, fit: BoxFit.fitHeight, height: 40.0),
        centerTitle: true,
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => currentState.articles.elementAt(index).featuredMediaUrl != null
              ? ArticleListElement(article: currentState.articles.elementAt(index), preferences: currentState.preferences)
              : ArticleListElement.reduced(article: currentState.articles.elementAt(index), preferences: currentState.preferences),
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: currentState.articles.length,
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(child: Image(image: Theme.of(context).brightness == Brightness.dark ? Images.logoLight : Images.logoDark)),
                      Center(
                        child: Text(
                          S.of(context).bocconiUniverisityNewspaper.toUpperCase(),
                          style: Theme.of(context).textTheme.caption.copyWith(letterSpacing: 1.0, fontStyle: FontStyle.italic),
                        ),
                      ),
                      // Text(S.of(context).appName),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    S.of(context).darkThemeTitle,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SwitchListTile(
                  title: Text(S.of(context).darkTheme),
                  value: (settingsBloc.latestSettingsModel.themeMode == ThemeMode.dark),
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (settingsBloc.latestSettingsModel.themeMode == ThemeMode.system)
                      ? null
                      : (bool dark) => settingsBloc.updateTheme(dark ? ThemeMode.dark : ThemeMode.light),
                ),
                CheckboxListTile(
                  title: Text(S.of(context).systemTheme),
                  value: (settingsBloc.latestSettingsModel.themeMode == ThemeMode.system),
                  onChanged: (bool system) => settingsBloc
                      .updateTheme(system ? ThemeMode.system : ((Theme.of(context).brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light))),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    S.of(context).language,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                _buildLanguageDropdown(context),
              ],
            ),
          ),
          // TODO: Valutare la questione.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("© 2020 Emilio Dalla Torre"),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        child: LanguagePickerDropdown(
          languagesList: S.delegate.supportedLocales
              .map((e) =>
                  {"name": LanguageHelper.getLanguageName(e.languageCode), "isoCode": "${e.languageCode}${e.countryCode == "" ? "" : "_${e.countryCode}"}"})
              .toList(),
          initialValue: settingsBloc.currentLocaleIso(),
          itemBuilder: (Language language) => Text(language.name, style: Theme.of(context).textTheme.button),
          onValuePicked: (Language language) => settingsBloc.updateLocale(Locale.fromSubtags(languageCode: language.isoCode)),
        ),
      ),
    );
  }
}
