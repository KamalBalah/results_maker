import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:results_maker/route.dart';
import 'package:results_maker/services/settings_service.dart';
import 'package:results_maker/services/translation_service.dart';
import 'package:results_maker/utils/languages/app_strings.dart';
import 'package:results_maker/views/home/home_view.dart';

import 'utils/app_theme.dart';

void main() async {
  await initServices();
  runApp(const StartPoint());
}

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('app_settings');
  await GetStorage.init('app_auth');
  await Get.putAsync(() => TranslationService().init());
  Get.put(SettingsService());
}

class StartPoint extends StatelessWidget {
  const StartPoint({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName.tr,
      getPages: AppPages.allRoutes,
      initialRoute: AppPages.initial,
      home: const HomeView(),
      defaultTransition: Transition.cupertino,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      locale: Get.find<SettingsService>().getLocale(),
      fallbackLocale: Get.find<TranslationService>().fallbackLocale,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getLightTheme(),

    );
  }
}
