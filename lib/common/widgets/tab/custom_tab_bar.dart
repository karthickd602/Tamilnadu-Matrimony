import '../../../utils/constants/path_provider.dart';
import '../appbar/appbar.dart';

class KTabBarPage extends StatelessWidget {
  final String title;
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final bool isBackButtonNeed;

  const KTabBarPage({
    super.key,
    required this.title,
    required this.tabs,
    required this.tabViews,
    this.isBackButtonNeed = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: TAppBar(
          title: title,
          isBackButtonNeed: isBackButtonNeed,
          bottom: TabBar(
            labelStyle: textTheme.labelLarge,
            labelColor: isDark ? TColors.secondary : TColors.primary,
            unselectedLabelColor:
            isDark ? TColors.lightGrey : TColors.darkerGrey,
            indicatorColor: isDark ? TColors.secondary : TColors.primary,
            tabs: tabs,
            isScrollable: false,
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.all(TSizes.defaultSpace),
          child: TabBarView(physics: NeverScrollableScrollPhysics(),children: tabViews,),
        ),
      ),
    );
  }
}
