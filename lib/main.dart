import 'package:anywherers_code_exercise/app/app_config.dart';
import 'package:anywherers_code_exercise/assets/constants.dart';
import 'package:anywherers_code_exercise/view/CharacterDetailsWidget.dart';
import 'package:anywherers_code_exercise/view/CharactersAndDetailsWidget.dart';
import 'package:anywherers_code_exercise/view/CharactersWidget.dart';
import 'package:anywherers_code_exercise/view/LoadingDataWidget.dart';
import 'package:flutter/material.dart';

void main() {
  const String tvShow = String.fromEnvironment('tv_show');

  AppConfig(tvShow);

  runApp(
    MaterialApp(
      initialRoute: Routes.home.name,
      routes: {
        Routes.home.name: (context) => LoadingDataWidget(AppConfigHelper()),
        Routes.characters.name: (context) =>
            CharactersWidget(const [], AppConfigHelper(), null),
        Routes.characterDetail.name: (context) =>
            const CharacterDetailsWidget(null),
        Routes.charactersAndDetail.name: (context) =>
            CharactersAndDetailsWidget(AppConfigHelper()),
      },
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppConfig.tvShow == TvShow.simpsons
              ? Colors.yellow[600]
              : Colors.grey[800],
        ),
      ),
    ),
  );
}
