import 'package:flutter/cupertino.dart';

enum TvShow {
  simpsons(name: 'simpsons characters'),
  theWire(name: 'the wire characters');

  const TvShow({required this.name});

  final String name;
}

class AppConfig {
  static final AppConfig _appConfig = AppConfig._internal();
  static TvShow? tvShow;
  static bool? _isTablet;

  factory AppConfig(String tvShowFilter) {
    if ("simpsons" == tvShowFilter) {
      tvShow = TvShow.simpsons;
    } else if ("the wire" == tvShowFilter) {
      tvShow = TvShow.theWire;
    }

    return _appConfig;
  }

  AppConfig._internal();

  static void setIsTablet(BuildContext context) {
    _isTablet ??= MediaQuery.of(context).size.width > 600;
  }

  static bool isTablet() {
    return _isTablet!;
  }
}
