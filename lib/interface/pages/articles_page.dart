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
        title: Image(image: Theme.of(context).brightness == Brightness.dark ? Images.icExtendedDark : Images.icExtended, fit: BoxFit.fitHeight, height: 40.0),
        centerTitle: true,
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => index.isEven
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
      child: ListView(
        children: <Widget>[
          CheckboxListTile(
            title: Text(S.of(context).systemTheme),
            value: (settingsBloc.latestSettingsModel.themeMode == ThemeMode.system),
            onChanged: (bool system) =>
                settingsBloc.updateTheme(system ? ThemeMode.system : ((Theme.of(context).brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light))),
          ),
          SwitchListTile(
            title: Text(S.of(context).darkTheme),
            value: (settingsBloc.latestSettingsModel.themeMode == ThemeMode.dark),
            onChanged: (settingsBloc.latestSettingsModel.themeMode == ThemeMode.system)
                ? null
                : (bool dark) => settingsBloc.updateTheme(dark ? ThemeMode.dark : ThemeMode.light),
          ),
          _buildLanguageDropdown(context),
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
          initialValue: "${settingsBloc.latestSettingsModel.locale.languageCode}${settingsBloc.latestSettingsModel.locale.countryCode == "" ? "" : "_${settingsBloc.latestSettingsModel.locale.countryCode}"}",
          itemBuilder: (Language language) => Text(language.name, style: Theme.of(context).textTheme.button),
          onValuePicked: (Language language) => settingsBloc.updateLocale(Locale.fromSubtags(languageCode: language.isoCode)),
        ),
      ),
    );
  }
}
