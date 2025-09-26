import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/services.dart';
import 'package:tamilnadu_matrimony/features/home/screen/home_page.dart';
import 'package:tamilnadu_matrimony/features/profile/screen/profile_page.dart';

import '../../../utils/constants/path_provider.dart';
import 'features/favorites/screen/favorites_page.dart';
import 'features/subscription/screen/subscription_page.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    final iconAndLabelColor = TColors.white;

    return PopScope(
      canPop: false, // prevent auto-pop
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldExit = await _showExitWarning(context);
        if (shouldExit ?? false) {
          // exit app
          Navigator.of(Get.context!).pop(true);
        }
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: SafeArea(
          child: Obx(
                () => CurvedNavigationBar(
              index: controller.selectedIndex.value,
              backgroundColor: TColors.bottomNavColor2,
              buttonBackgroundColor: TColors.bottomNavColor,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 600),
              color: darkMode
                  ? TColors.yellow
                  : TColors.bottomNavColor,
              onTap: (index) {
                controller.selectedIndex.value = index;
              },
              items:  [
                CurvedNavigationBarItem(
                  child: Icon(Iconsax.home, color: iconAndLabelColor),
                  label: 'Home',
                  labelStyle: TextStyle(color:iconAndLabelColor),
                ),
                CurvedNavigationBarItem(
                  child: Icon(Iconsax.heart, color: iconAndLabelColor),
                  label: 'Favorites',
                  labelStyle: TextStyle(color: iconAndLabelColor),
                ),CurvedNavigationBarItem(
                  child: Icon(Icons.wallet_outlined, color: iconAndLabelColor),
                  label: 'Subscription',
                  labelStyle: TextStyle(color: iconAndLabelColor),
                ),
                CurvedNavigationBarItem(
                  child: Icon(Iconsax.user, color: iconAndLabelColor),
                  label: 'Profile',
                  labelStyle: TextStyle(color: iconAndLabelColor),
                ),
              ],
            ),
          ),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
      ),
    );
  }

  Future<bool?> _showExitWarning(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to close the app?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => SystemNavigator.pop(),
            child: const Text("Exit"),
          ),
        ],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  RxInt back = 0.obs;
  final screens = [
    HomePage(),
    FavoritesPage(),
    SubscriptionPage(),
    ProfilePage(),
  ];
}
