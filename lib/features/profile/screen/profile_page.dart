import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/common/widgets/images/image_preview_page.dart';
import 'package:tamilnadu_matrimony/features/profile/screen/verified_profile/verify_profile.dart';

import '../../../common/widgets/dialog/logout_dialog.dart';
import '../../../utils/constants/path_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: TTexts.profile.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Photo
              Center(
                child: Column(
                  children: [
                    InkWell(
                      onTap: ()=>Get.to(()=>ImagePreviewPage(imageUrl: TImages.sampleUser)),
                      child: TRoundedImage(
                        width: 100,
                        height: 100,
                        imageType: ImageType.asset,
                        image: TImages.sampleUser,
                        fit: BoxFit.cover,
                        borderRadius: 100,
                      ),
                    ),
                    const SizedBox(height: TSizes.sm),
                    Text(
                      "Karthick, 35", // Dynamic later
                      style: Theme.of(context).textTheme.headlineMedium
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Menu Items
              _buildMenuItem(context,Icons.person_outline, TTexts.editProfile.tr, () {}),

              _buildMenuItem(context,Icons.camera_alt_outlined, TTexts.updatePhoto.tr, () {}),
              _buildMenuItem(context,Icons.verified_outlined, TTexts.verifyProfile.tr, () {
Get.to(()=>VerifyProfile());
              }),
              _buildMenuItem(context,Icons.headset_mic_outlined, TTexts.helpSupport.tr, () {}),
              _buildMenuItem(context,Icons.card_membership_outlined, TTexts.membershipDetails.tr, () {
                Get.toNamed(TRoutes.subscription);
              }),
              _buildMenuItem(context,Icons.share_outlined, TTexts.shareProfile.tr, () {}),
              _buildMenuItem(context,Icons.delete_outline, TTexts.logout.tr, () {
                showLogoutDialog(context);
              }, isDanger: true),
              _buildMenuItem(context,Icons.delete_outline, TTexts.deleteProfile.tr, () {

              }, isDanger: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem( BuildContext context,IconData icon, String title, VoidCallback onTap,
      {bool isDanger = false,}) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon, color: isDanger ? Colors.red : TColors.primary),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isDanger ? Colors.red :(THelperFunctions.isDarkMode(context)?TColors.white: Colors.black),
              fontWeight: isDanger ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
        Divider(),
      ],
    );
  }
}
