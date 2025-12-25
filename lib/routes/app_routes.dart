import 'package:tamilnadu_matrimony/features/authentication/screen/language_selection/screen/language_selection.dart';
import 'package:tamilnadu_matrimony/features/authentication/screen/otp/otp_page.dart';
import 'package:tamilnadu_matrimony/features/authentication/screen/register/register_page.dart';
import 'package:tamilnadu_matrimony/features/home/bindings/filter_bindings.dart';
import 'package:tamilnadu_matrimony/features/home/screen/filter/filter_screen.dart';
import 'package:tamilnadu_matrimony/features/profile/screen/edit_profile/edit_profile_page.dart';
import 'package:tamilnadu_matrimony/features/subscription/screen/subscription_page.dart';

import '../features/authentication/screen/login/login_page.dart';
import '../features/profile/screen/view_profile/view_profile_page.dart';
import '../features/splash/splash_screen.dart';
import '../features/subscription/screen/active_subscription_page.dart';
import '../navigation_menu.dart';
import '../utils/constants/path_provider.dart';

class TAppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: TRoutes.splash, page: () => SplashPage()),
    GetPage(
      name: TRoutes.languageSelection,
      page: () => LanguageSelectionPage(),
    ),
    GetPage(name: TRoutes.loginPage, page: () => LoginPage()),
    GetPage(name: TRoutes.otp, page: () => OtpPage()),
    GetPage(name: TRoutes.register, page: () => RegistrationPage()),
    GetPage(name: TRoutes.bottomNav, page: () => NavigationMenu()),
    GetPage(
      name: TRoutes.filter,
      binding: FilterBindings(),
      page: () => FilterPage(),
    ),
    GetPage(name: TRoutes.buySubscription, page: () => SubscriptionPage()),
    GetPage(
      name: TRoutes.userSubscriptionPlan,
      page: () => ActiveSubscriptionPage(),
    ),
    GetPage(name: TRoutes.editProfile, page: () => EditProfilePage()),
    GetPage(name: TRoutes.viewProfile, page: () => ViewProfilePage()),
  ];
}
