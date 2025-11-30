import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../constants/path_provider.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final RxBool _isConnected = true.obs;
  bool get isOnline => _isConnected.value;

  @override
  void onInit() {
    super.onInit();
    _listenToConnectivityChanges();
  }

  void _listenToConnectivityChanges() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
        List<ConnectivityResult> result,
        ) {
      _handleConnectionChange(result);
    });
  }

  void _handleConnectionChange(List<ConnectivityResult> result) async {
    final bool connected = !result.contains(ConnectivityResult.none);

    if (!connected && _isConnected.value) {
      _isConnected.value = false;
      TLoaders.warningSnackBar(
        title: "No Internet",
        message: "Please check your network connection.",
      );
      return;
    }

    if (connected && !_isConnected.value) {
      _isConnected.value = true;
      TLoaders.successSnackBar(
        title: "Back Online",
        message: "You're now connected to the internet.",
      );
    }

    // 🟡 CHECK SLOW INTERNET
    if (connected) {
      final bool fast = await NetworkSpeedChecker.isNetworkFast();

      if (!fast) {
        TLoaders.warningSnackBar(
          title: "Slow Connection",
          message: "Your internet is weak or unstable. Some features may fail.",
        );
      }
    }
  }
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      final bool connected = !result.contains(ConnectivityResult.none);

      if (!connected) return false;

      // 🔍 Extra check: real internet & speed check
      final bool fast = await NetworkSpeedChecker.isNetworkFast();
      return fast;
    } on PlatformException {
      return false;
    }
  }


  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }
}

class NetworkSpeedChecker {
  /// Returns:
  /// true = good internet
  /// false = poor or unstable internet
  static Future<bool> isNetworkFast() async {
    try {
      final stopwatch = Stopwatch()..start();
      final result = await InternetAddress.lookup('google.com');

      stopwatch.stop();
      final ping = stopwatch.elapsedMilliseconds;

      print("📡 Network Ping: $ping ms");

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (ping > 800) return false;
        if (ping > 500) return false;
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }
}
