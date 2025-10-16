
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'features/authentication/controller/language/translation_services.dart';

/// Entry point of Flutter App
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  GetStorage.init();

  final translations = await TranslationService.loadTranslations();

  runApp(MyApp(translations: translations));
}
