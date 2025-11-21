import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/common/widgets/images/image_preview_page.dart';
import 'package:tamilnadu_matrimony/features/profile/screen/verified_profile/verify_profile.dart';

import '../../../common/widgets/dialog/logout_dialog.dart';
import '../../../utils/constants/path_provider.dart';
import '../../../utils/helpers/url_launcher.dart';
import 'edit_profile/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(title: TTexts.profile.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Profile Header
              Column(
                children: [
                  InkWell(
                    onTap: () => Get.to(
                          () => ImagePreviewPage(imageUrl: TImages.sampleUser),
                    ),
                    borderRadius: BorderRadius.circular(100),
                    child: TRoundedImage(
                      width: 110,
                      height: 110,
                      imageType: ImageType.asset,
                      image: TImages.sampleUser,
                      fit: BoxFit.cover,
                      borderRadius: 100,
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Karthick, 35",
                        style: textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.verified,
                          color: Colors.blueAccent.shade700,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ID: MAT123456 | Active Member",
                    style:
                    textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),

              /// Menu Items
              _buildMenuItem(context, Icons.person_outline,
                  TTexts.editProfile.tr, () {
                Get.to(()=> const EditProfilePage());
                  }),
              _buildMenuItem(context, Icons.camera_alt_outlined,
                  TTexts.updatePhoto.tr, () {}),
              _buildMenuItem(
                context,
                Icons.verified_outlined,
                TTexts.verifyProfile.tr,
                    () => Get.to(() => const VerifyProfile()),
              ),
              _buildMenuItem(
                context,
                Icons.headset_mic_outlined,
                TTexts.helpSupport.tr,
                    () => _showHelpDialog(context),
              ),
              _buildMenuItem(
                context,
                Icons.card_membership_outlined,
                TTexts.membershipDetails.tr,
                    () => Get.toNamed(TRoutes.subscription),
              ),
              _buildMenuItem(
                context,
                Icons.share_outlined,
                TTexts.shareProfile.tr,
                    () {},
              ),
              const Divider(height: 30),

              /// Danger Section
              _buildMenuItem(
                context,
                Icons.logout_outlined,
                TTexts.logout.tr,
                    () => showLogoutDialog(context),
                isDanger: true,
              ),
              _buildMenuItem(
                context,
                Icons.delete_forever_outlined,
                TTexts.deleteProfile.tr,
                    () {},
                isDanger: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- HELP DIALOG ---
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.support_agent,
                      color: Colors.blueAccent, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    "Help & Support",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent.shade700),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),

              /// Info Rows
              _infoRow(Icons.phone_in_talk, "Call", "0452-4380101"),
              _infoRow(Icons.email_outlined, "Mail",
                  "info@tamilnadumatrimony.net"),
              _infoRow(Icons.location_on_outlined, "Address",
                  "Tamilnadu Matrimony,\n95, Northveli Street,\nSimmakal Bus Stop,\nMadurai - 625001."),
              _infoRow(
                  Icons.access_time_outlined, "Timing", "10:00 AM - 6:30 PM"),

              const SizedBox(height: 25),

              /// Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){
                      TUrlLauncher.callPhone("04524380101");
                    },
                    // onPressed: () => _launchCaller("04524380101"),
                    icon: const Icon(Icons.call, size: 20),
                    label: const Text("Call Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      TUrlLauncher.sendMail(email: "info@tamilnadumatrimony.net");
                    },
                    // onPressed: () => _launchEmail(
                    //     "info@tamilnaduMatrimony.net", "Tamilnadu Matrimony"),
                    icon: const Icon(Icons.email_outlined, size: 20),
                    label: const Text("Send Mail"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      side: BorderSide(color: Colors.blueAccent),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text("Close"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: TColors.red,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable info display
  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(color: Colors.black87, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// --- Utility Launchers ---
  // Future<void> _launchCaller(String number) async {
  //   final Uri url = Uri(scheme: 'tel', path: number);
  //   if (await launchUrl(url)) {
  //     Get.snackbar("Error", "Could not open dialer.",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }
  //
  // Future<void> _launchEmail(String email, String subject) async {
  //   final Uri url = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //     query: 'subject=$subject',
  //   );
  //   if (!await launchUrl(url)) {
  //     Get.snackbar("Error", "Could not open email app.",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  /// --- Menu item builder ---
  Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String title,
      VoidCallback onTap, {
        bool isDanger = false,
      }) {
    final isDark = THelperFunctions.isDarkMode(context);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      leading: CircleAvatar(
        backgroundColor: isDanger
            ? Colors.red.withOpacity(0.1)
            : TColors.primary.withOpacity(0.1),
        child:
        Icon(icon, color: isDanger ? Colors.red : TColors.primary, size: 22),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: isDanger
              ? Colors.red
              : (isDark ? TColors.white : Colors.black87),
          fontWeight: isDanger ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing:
      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}
