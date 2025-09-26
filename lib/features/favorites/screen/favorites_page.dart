import 'package:flutter/material.dart';
import 'package:tamilnadu_matrimony/common/widgets/tab/custom_tab_bar.dart';

import '../../../utils/constants/path_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KTabBarPage(
      title: "Favorite",
      tabs: const [
        Tab(icon: Icon(Icons.thumb_up_alt_outlined, color: Colors.black), text: "Liked"),
        Tab(icon: Icon(Icons.favorite_border, color: Colors.black), text: "Favorite"),
      ],
      tabViews: const [
        Center(child: Text("Liked Profiles")),
        Center(child: Text("Favorite Profiles")),
      ],
    );
  }
}
