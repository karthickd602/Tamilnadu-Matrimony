import 'package:flutter/foundation.dart';

/// A reusable function to print logs only in debug mode,
/// preventing them from showing up in release/production versions (e.g., Play Store).
void appDebugPrint(dynamic message) {
  if (kDebugMode) {
    debugPrint(message.toString());
  }
}
