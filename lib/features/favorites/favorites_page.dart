import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/common/widgets/tab/custom_tab_bar.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/text_strings.dart';
import 'screen/like_page.dart';
import 'screen/unlocked_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = TColors.primary;

    return KTabBarPage(
      title: TTexts.favorite.tr,
      tabs: [
        Tab(
          icon: Icon(Icons.thumb_up_alt_outlined, color: primaryColor),
          text: TTexts.liked.tr,
        ),
        Tab(
          icon: Icon(Icons.favorite_border, color: primaryColor),
          text: TTexts.unlocked.tr,
        ),
      ],
      tabViews: const [
        LikePage(),
        UnlockedPage(),
      ],
    );
  }
}
