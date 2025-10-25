
import '../../../utils/constants/path_provider.dart';


class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    required this.title,
    this.isBackButtonNeed = false,
    this.bottom,
    this.actions,
    this.backgroundColor
  });

  final String title;
  final bool isBackButtonNeed;
  final TabBar? bottom;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor??TColors.scaffoldColor,
      leading: isBackButtonNeed
          ? IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: isDark ? Colors.white : Colors.black87,
        ),
        tooltip: "Back",
      )
          : null,
      title: Column(
        children: [
          Text(title, style: textTheme.headlineMedium,maxLines: 2,),
        ],
      ),
      actions: actions,
      bottom: bottom,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    bottom == null ? TSizes.appBarHeight : TSizes.appBarHeight * 2.1,
  );
}
