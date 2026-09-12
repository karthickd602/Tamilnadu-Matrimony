import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/text_strings.dart';

class TranslationService {
  static Locale get locale {
    final storage = GetStorage();
    final code = storage.read(TTexts.languageCode);
    if (code == 'ta') {
      return const Locale('ta', 'IN');
    }
    return const Locale('en', 'US');
  }

  static Locale get fallbackLocale => const Locale('en', 'US');

  static Future<Map<String, Map<String, String>>> loadTranslations() async {
    return {
      'en_US': await _loadJson('assets/translation/en_US.json'),
      'ta_IN': await _loadJson('assets/translation/ta_IN.json'),
    };
  }

  static Future<Map<String, String>> _loadJson(String path) async {
    final data = await rootBundle.loadString(path);
    return Map<String, String>.from(json.decode(data));
  }
}
