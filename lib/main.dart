
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'features/authentication/controller/language/translation_services.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage
  GetStorage.init();
  // Initialize Firebase & Authentication Repository
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final translations = await TranslationService.loadTranslations();

  runApp(MyApp(translations: translations));
}
