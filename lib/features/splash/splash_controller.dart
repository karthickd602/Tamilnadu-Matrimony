import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../profile/controller/profile_controller.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  final storage = GetStorage();
  final profileController = Get.put(ProfileController());

  @override
  void onInit() {
    super.onInit();
    checkVersion();
  }

  Future<void> checkVersion() async {
    try {
      if (Platform.isWindows) {
        Future.delayed(const Duration(seconds: 3), () {
          validate();
        });
        return;
      }

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final body = {
        "platform": Platform.isAndroid ? "android" : "ios",
        "current_version": currentVersion,
      };
      debugPrint("Version check body: $body");
      final response = await THttpHelper.post(
        ApiConstant.appVersionCheckEndPoint,
        body,
      );
      debugPrint("Version check response: $response");
      if (response['statusCode'] == 200) {
        final bool forceUpdate = response['force_update'] ?? false;
        if (forceUpdate) {
          final String message = response['message'] ?? "New version available";
          final String storeUrl = response['playstore_url'] ?? "";

          _showUpdateDialog(message, storeUrl);
        } else {
          validate();
        }
      } else {
        validate();
      }
    } catch (e) {
      debugPrint("Version check failed: $e");
      validate();
    }
  }

  void _showUpdateDialog(String message, String url) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text("Update Available"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: const Text("Update Now"),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void validate() async {
    if (storage.read(TTexts.userId) != null) {
      if (storage.read(TTexts.appPages) == 0) {
        Get.offAllNamed(TRoutes.bottomNav);
      } else {
        Get.offAllNamed(TRoutes.register);
        // await profileController.fetchUserProfile();
      }
    } else {
      Get.offAllNamed(TRoutes.languageSelection);
    }
    // await storage.write(TTexts.userId, "11623");

    debugPrint("userId: ${storage.read(TTexts.userId)}");
    // Get.offAllNamed(TRoutes.loginPage);

    // Get.offAllNamed(TRoutes.languageSelection);
    // Get.offAllNamed(TRoutes.bottomNav);
  }
}
