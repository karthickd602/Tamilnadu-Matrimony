import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/home/controller/dashboard_controller.dart';
import '../../features/home/screen/customer_view_page.dart';

class DynamicLinkService extends GetxService {
  static DynamicLinkService get instance => Get.find();

  final _appLinks = AppLinks();

  @override
  void onReady() {
    super.onReady();
    // Add start-up delay to ensure navigation stack is ready (fixes GlobalKey error on cold start)
    Future.delayed(const Duration(milliseconds: 1000), () {
      initDynamicLinks();
    });
  }

  Future<void> initDynamicLinks() async {
    debugPrint("DynamicLinkService: Initializing...");

    // 1. Handle the initial link (if the app was opened via a link)
    final Uri? initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      debugPrint("DynamicLinkService: Found initial link: $initialLink");
      _handleDeepLink(initialLink);
    }

    // 2. Listen for new links while the app is running
    _appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint("DynamicLinkService: Stream received link: $uri");
        _handleDeepLink(uri);
      },
      onError: (err) {
        debugPrint('DynamicLinkService Error: $err');
      },
    );
  }

  DateTime? _lastLinkTime;

  void _handleDeepLink(Uri deepLink) {
    debugPrint('DynamicLinkService: Handling Link: $deepLink');

    // STRICT Debounce: Ignore ANY second link within 1.5 seconds.
    // This prevents the "GlobalKey" collision if the OS sends the link twice (Intent vs Stream)
    // or if the user double-clicks.
    final now = DateTime.now();
    if (_lastLinkTime != null &&
        now.difference(_lastLinkTime!).inMilliseconds < 1500) {
      debugPrint('DynamicLinkService: Ignoring duplicate/rapid link event.');
      return;
    }

    _lastLinkTime = now;

    _lastLinkTime = now;

    // Expected format: https://tamilnadu-matrimony.com/profile?id=123
    // or custom scheme: tamilnadumatrimony://profile?id=123

    // Check for "id" parameter
    if (deepLink.queryParameters.containsKey('id')) {
      final String? profileId = deepLink.queryParameters['id'];
      if (profileId != null) {
        _navigateToProfile(int.tryParse(profileId));
      }
    }
  }

  Future<void> _navigateToProfile(int? profileId) async {
    if (profileId == null) return;

    // Ensure DashboardController is available
    final dashboardController = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());

    // Show loading or navigate
    // Since we need to fetch data, let's call the controller method
    await dashboardController.fetchCustomerPage(profileId);

    // Navigate
    Get.to(() => const CustomerDetailsView());
  }

  // Generates a standard web URL that will be intercepted by the app
  String createProfileShareLink(String userId) {
    // Using custom scheme for testing (since assetlinks.json is not on server)
    return 'tamilnadumatrimony://profile?id=$userId';
  }
}
