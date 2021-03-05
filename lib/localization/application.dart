import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todoapp/localization/app_translations_delegate.dart';

const VN_CODE = 'vi';
const EN_CODE = 'en';

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  final List<String> supportedLanguages = [
    'English',
    'Vietnamese',
  ];

  final List<String> supportedLanguagesCodes = [
    EN_CODE,
    VN_CODE,
  ];

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ''));

  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;
}

Application application = Application();
AppTranslationsDelegate newLocaleDelegate;
String langCode;

typedef LocaleChangeCallback = void Function(Locale locale);

Future<void> initLangCode() async {
  langCode = EN_CODE;
}
