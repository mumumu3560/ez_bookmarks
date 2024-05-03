import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language.g.dart';

@riverpod
class LanguageNotifier extends _$LanguageNotifier{

  static final languages = [
    "en",
    "ja",
  ];

  @override
  AppLocale build() {
    if(!languages.contains(LocaleSettings.currentLocale.languageCode)){
      return AppLocale.en;
    }
    return LocaleSettings.currentLocale;

  }

  //ここでthemeModeを変更する。
  void updateLocale(AppLocale newLocale) {

    state = newLocale;
    LocaleSettings.setLocale(newLocale);
  }


}