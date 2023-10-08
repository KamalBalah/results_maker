import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/languages/ar.dart';
import '../utils/languages/en.dart';

class TranslationService extends GetxService {
  final Map<String, Map<String, String>> translations =
      <String, Map<String, String>>{};

  // fallbackLocale saves the day when the locale gets in trouble
  final Locale fallbackLocale = const Locale('en');

  // supported languages
  final List<String> languages = [
    'en',
    'ar',
  ];

  Future<TranslationService> init() async {
    Map<String, String> currentLanguage;
    languages.forEach((lang) async {
      switch (lang) {
        case 'en':
          currentLanguage = en;
          break;
        case 'ar':
          currentLanguage = ar;
          break;
        default:
          currentLanguage = en;
      }
      translations.putIfAbsent(lang, () => currentLanguage);
    });
    return this;
  }

  // get list of supported local in the application
  List<Locale> supportedLocales() {
    return languages.map((locale) {
      return fromStringToLocale(locale);
    }).toList();
  }

  // Convert string code to local object
  Locale fromStringToLocale(String locale) {
    if (locale.contains('_')) {
      // en_US
      return Locale(
          locale.split('_').elementAt(0), locale.split('_').elementAt(1));
    } else {
      // en
      return Locale(locale);
    }
  }
}
