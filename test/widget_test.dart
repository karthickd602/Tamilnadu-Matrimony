// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tamilnadu_matrimony/app.dart';
void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Provide mock translations
    final mockTranslations = {
      'en_US': {'hello': 'Hello'},
      'ta_IN': {'hello': 'வணக்கம்'},
    };

    // Build our app with mock translations
    await tester.pumpWidget(MyApp(translations: mockTranslations));

    // Example check: verify app builds
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
