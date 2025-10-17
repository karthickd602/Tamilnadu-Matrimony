import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetDialog {
  static void show({required Future<bool> Function() onRetry}) {
    if (Get.isDialogOpen == true) return; // prevent duplicate dialogs

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          bool isChecking = false;

          Future<void> handleRetry() async {
            setState(() => isChecking = true);

            final connected = await onRetry();

            if (connected) {
              Get.back(); // ✅ Close dialog only if internet is back
            } else {
              // Keep dialog open
              setState(() => isChecking = false);
            }
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wifi_off, size: 60, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  Text(
                    "No Internet Connection",
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please check your internet connection and try again.",
                    style: Get.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () => Get.back(),
                        child: const Text("Close"),
                      ),
                      ElevatedButton.icon(
                        onPressed: isChecking ? null : handleRetry,
                        icon: isChecking
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.refresh, size: 18),
                        label: Text(isChecking ? "Checking..." : "Retry"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      barrierDismissible: false,
    );
  }
}
