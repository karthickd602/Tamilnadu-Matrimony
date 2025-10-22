import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TUrlLauncher {
  /// Open a phone dialer
  static Future<void> callPhone(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    await _launch(url, 'Unable to open phone dialer');
  }

  /// Open email app with prefilled address, subject, and body
  static Future<void> sendMail({
    required String email,
    String subject = '',
    String body = '',
  }) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=$subject&body=$body',
    );
    await _launch(url, 'Unable to open mail app');
  }

  /// Open any website link
  static Future<void> openWeb(String urlString) async {
    final Uri url = Uri.parse(urlString);
    await _launch(url, 'Unable to open web link');
  }

  /// Open location on Google Maps
  static Future<void> openMap(String query) async {
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    await _launch(url, 'Unable to open map');
  }

  /// Internal reusable launcher with error handling
  static Future<void> _launch(Uri url, String errorMessage) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    }
  }
}
