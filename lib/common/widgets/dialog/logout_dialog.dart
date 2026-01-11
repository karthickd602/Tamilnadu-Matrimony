import '../../../utils/constants/path_provider.dart';

/// Function to show the Logout Dialog
Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.dark
            : TColors.light,
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        child: const LogoutDialogContent(),
      );
    },
  );
}

/// Reusable widget for Logout Dialog Content
class LogoutDialogContent extends StatelessWidget {
  const LogoutDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Icon
            CircleAvatar(
              radius: 30,
              backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1),
              child: Icon(Icons.logout, color: TColors.red, size: 32),
            ),
            const SizedBox(height: 20),

            /// Title
            Text(
              "Logout",
              style: theme.textTheme.titleLarge?.merge(
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            /// Subtitle
            Text(
              "Are you sure you want to logout from your account?",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.lg),

            /// Buttons
            Row(
              children: [
                /// Cancel button
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Get.back(); // close dialog
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 16),

                /// Logout button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.red,
                      side: BorderSide(color: TColors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      final storage = GetStorage();
                      await storage.erase();
                      Get.offAllNamed(TRoutes.loginPage);
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
