import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../features/home/controller/dashboard_controller.dart';
import '../../routes/routes.dart';
import '../../utils/constants/text_strings.dart';

class DynamicLinkService extends GetxService {
  static DynamicLinkService get instance => Get.find();

  final _appLinks = AppLinks();
  final _storage = GetStorage();

  bool isHandled = false;
  bool _lock = false;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    debugPrint("DynamicLinkService: Initializing AppLinks Engine...");
    
    // Optimistically set to true to stall Splash until we check for initial link
    isHandled = true; 

    // 1. Cold Start Check
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        debugPrint("DynamicLinkService: !!! Cold Start Link detected: $initialLink");
        // isHandled remains true to keep Splash waiting
        _processSafe(initialLink, delay: 1500); 
      } else {
        // No cold start link, tellSplash it's safe to proceed
        isHandled = false;
      }
    } catch (e) {
      debugPrint("DynamicLinkService: Cold start error: $e");
      isHandled = false;
    }

    // 2. Stream Check (Warm Start)
    _appLinks.uriLinkStream.listen((uri) {
      debugPrint("DynamicLinkService: Link received via stream: $uri");
      
      // If we are currently handling a handoff, don't trigger twice
      if (isHandled && !_lock) {
         debugPrint("DynamicLinkService: Ignoring stream link during cold-start handoff.");
         return;
      }
      
      _processSafe(uri, delay: 500);
    });
  }

  Future<void> _processSafe(Uri uri, {required int delay}) async {
    if (_lock) return;
    _lock = true;

    try {
      final profileId = _parseId(uri);
      if (profileId == null) {
        isHandled = false;
        return;
      }

      // Ensure user is logged in
      final userId = _storage.read(TTexts.userId);
      if (userId == null || userId.isEmpty) {
        debugPrint("DynamicLinkService: No user logged in. Aborting.");
        isHandled = false;
        return;
      }

      // 1. Wait for stability
      await Future.delayed(Duration(milliseconds: delay));
      while (Get.context == null) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      debugPrint("DynamicLinkService: Processing Profile $profileId (Atomic Flow)");
      
      // 2. Prepare data silently
      final dashboardController = Get.isRegistered<DashboardController>()
          ? Get.find<DashboardController>()
          : Get.put(DashboardController());
      await dashboardController.fetchCustomerPage(profileId, showLoader: false);

      // 3. STABLE NAVIGATION SEQUENCE
      // A. If we are not on BottomNav, reset to it first.
      if (Get.currentRoute != TRoutes.bottomNav) {
        debugPrint("DynamicLinkService: Resetting route stack...");
        Get.offAllNamed(TRoutes.bottomNav);
        
        // CRITICAL: Wait for Navigator to fully transition and update GetX route state
        // This prevents the GlobalKey collision by ensuring we don't 'push' during 'reset'.
        int settleTimeout = 0;
        while (Get.currentRoute != TRoutes.bottomNav && settleTimeout < 30) {
          await Future.delayed(const Duration(milliseconds: 100));
          settleTimeout++;
        }
      }

      // B. Extra cushion for animations to settle
      await Future.delayed(const Duration(milliseconds: 200));

      // C. Final push
      if (Get.currentRoute != TRoutes.customerDetails) {
        debugPrint("DynamicLinkService: Navigating to Profile Page.");
        Get.toNamed(TRoutes.customerDetails);
      }

    } catch (e) {
      debugPrint("DynamicLinkService Navigation Error: $e");
    } finally {
      isHandled = false; // Always release Splash
      // Debounce lock for spam prevention
      Future.delayed(const Duration(milliseconds: 2000), () {
        _lock = false;
      });
    }
  }

  int? _parseId(Uri uri) {
    if (uri.queryParameters.containsKey('id')) {
      return int.tryParse(uri.queryParameters['id'] ?? '');
    }
    return null;
  }

  String createProfileShareLink(String userId) {
    return 'https://tamilnadumatrimony.net/profile?id=$userId';
  }
}
