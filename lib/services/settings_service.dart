import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:results_maker/services/translation_service.dart';

import '../utils/local_db_keys.dart';

class SettingsService extends GetxService {
  late Locale selectedLanguage;

  bool get isArabic => selectedLanguage.languageCode == 'ar';
  GetStorage? _settingsBox;

  // GetStorage? _tutorialGuideBox;

  @override
  void onInit() {
    super.onInit();
    _settingsBox = GetStorage('app_settings');
    // _tutorialGuideBox = GetStorage('tutorial_guide');
  }

  /// language methods
  Locale getLocale() {
    String? locale =
        GetStorage('app_settings').read<String>(LocalDBKeys.language);
    if (locale == null || locale.isEmpty) {
      locale = Get.deviceLocale?.languageCode == 'en' ? 'en' : 'ar';
    }
    selectedLanguage =
        Get.find<TranslationService>().fromStringToLocale(locale);
    return selectedLanguage;
  }

  void updateLocale(Locale? value) async {
    if (value == null) return;
    Get.find<SettingsService>().selectedLanguage = value;
    Get.updateLocale(value);
    if (value.countryCode?.isEmpty ?? true) {
      await _settingsBox?.write(LocalDBKeys.language, value.languageCode);
    } else {
      await _settingsBox?.write(
          LocalDBKeys.language, "${value.languageCode}_${value.countryCode!}");
    }
  }
}
