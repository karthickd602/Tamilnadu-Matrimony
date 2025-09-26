import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';

import '../../../common/widgets/images/image_preview_page.dart';
import '../../../utils/constants/path_provider.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: TTexts.profileDetails.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(TSizes.defaultSpace),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image
              InkWell(
                onTap: ()=>Get.to(()=> ImagePreviewPage(imageUrl: TImages.sampleUser)),
                child: Center(
                  child: TRoundedImage(
                    width: double.infinity,
                    height: 250,
                    imageType: ImageType.asset,
                    image:  TImages.sampleUser, // dynamic later
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Name + Age
              Center(
                child: Text(
                  "Jameela, 35",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// PERSONAL DETAILS
              _buildSectionHeader(context, TTexts.personalDetails.tr),
              _buildDetailItem(Icons.cake, TTexts.dateOfBirth.tr, "1989-11-25"),
              _buildDetailItem(Icons.people, TTexts.caste.tr, "Muslim | Hanafi"),
              _buildDetailItem(Icons.location_on, TTexts.location.tr, "Chennai"),
              _buildDetailItem(Icons.language, TTexts.motherTongue.tr, "Tamil"),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// BASIC DETAILS
              _buildSectionHeader(context, TTexts.basicDetails.tr),
              _buildDetailItem(Icons.person_add, TTexts.profileCreatedFor.tr, "Myself"),
              _buildDetailItem(Icons.favorite, TTexts.maritalStatus.tr, "Divorced"),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// OCCUPATION DETAILS
              _buildSectionHeader(context, TTexts.occupationDetails.tr),
              _buildDetailItem(Icons.work, TTexts.jobType.tr, "Private Job"),
              _buildDetailItem(Icons.currency_rupee, TTexts.salary.tr, "20,000 - 50,000"),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// EDUCATION DETAILS
              _buildSectionHeader(context, TTexts.educationDetails.tr),
              _buildDetailItem(Icons.school, TTexts.highestQualification.tr, "Bachelor's Degree"),

              const SizedBox(height: TSizes.spaceBtwSections * 2),

              /// Action Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},

                      icon: const Icon(Icons.share, color: TColors.primary),
                      label: Text(
                        TTexts.shareProfile.tr,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: TColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},

                      icon: const Icon(Icons.call, color: Colors.white),
                      label: Text(
                        TTexts.unlockNumber.tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Header
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TSizes.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Detail Row
  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: TSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
