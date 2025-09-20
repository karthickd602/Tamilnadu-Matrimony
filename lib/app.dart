
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/general_binding.dart';
import 'features/authentication/controller/language/translation_services.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';
import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {

  final Map<String, Map<String, String>> translations;
  const MyApp({super.key, required this.translations});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: TTexts.appName,
      initialBinding: GeneralBinding(),
      translations: MapTranslations(translations),
    locale: TranslationService.locale,
    fallbackLocale: TranslationService.fallbackLocale,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      getPages: TAppRoutes.pages,
      initialRoute: TRoutes.splash,

    );
  }
}


class MapTranslations extends Translations {
  final Map<String, Map<String, String>> data;
  MapTranslations(this.data);

  @override
  Map<String, Map<String, String>> get keys => data;
}
