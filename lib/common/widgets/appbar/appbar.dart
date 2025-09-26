
import '../../../utils/constants/path_provider.dart';


class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    required this.title,
    this.isBackButtonNeed = false,
    this.bottom,
    this.actions,
  });

  final String title;
  final bool isBackButtonNeed;
  final TabBar? bottom;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: isDark ? TColors.black : TColors.white,
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
      title: Text(title, style: textTheme.headlineSmall),
      actions: actions,
      bottom: bottom,
      // shape: RoundedRectangleBorder(
      //   borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      //   side: BorderSide(
      //     color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      //   ),
      // ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    bottom == null ? TSizes.appBarHeight : TSizes.appBarHeight * 2.1,
  );
}
