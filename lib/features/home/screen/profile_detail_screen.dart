import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';
import '../../../common/widgets/images/image_preview_page.dart';

class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = TColors.primary;
    final secondaryColor = Colors.grey[100]!;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: TAppBar(
        title: TTexts.appName.tr,
        isBackButtonNeed: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.language),
        //     onPressed: () {
        //       if (Get.locale?.languageCode == 'en') {
        //         Get.updateLocale(const Locale('ta', 'IN'));
        //       } else {
        //         Get.updateLocale(const Locale('en', 'US'));
        //       }
        //     },
        //   )
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Profile Image
              GestureDetector(
                onTap: () => Get.to(() => ImagePreviewPage(
                    imageUrl: TImages.sampleUser, imageType: ImageType.asset)),
                child: TRoundedImage(
                  width: double.infinity,
                  height: 400,
                  margin: 0,
                  padding: 0,
                  borderRadius: 0,
                  imageType: ImageType.asset,
                  image: TImages.sampleUser,
                  backgroundColor: TColors.white,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Info Sections
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    _infoCard(
                      TTexts.basicInfo.tr,
                      Icons.person_outline,
                      [
                        {
                          "icon": Icons.badge,
                          "label": TTexts.nameAge.tr,
                          "value": "மரியலட்சுமி, 25 yrs"
                        },
                        {
                          "icon": Icons.location_on,
                          "label": TTexts.location.tr,
                          "value": "Thanjavur, தமிழ்நாடு"
                        },
                        {
                          "icon": Icons.favorite,
                          "label": TTexts.maritalStatus.tr,
                          "value": "Unmarried"
                        },
                        {
                          "icon": Icons.cake,
                          "label": TTexts.dob.tr,
                          "value": "23-02-2000"
                        },
                      ],
                      primaryColor,
                    ),
                    _infoCard(
                      TTexts.educationOccupation.tr,
                      Icons.school_outlined,
                      [
                        {
                          "icon": Icons.menu_book,
                          "label": TTexts.degree.tr,
                          "value": "Bachelors in Arts (BA)"
                        },
                        {
                          "icon": Icons.work_outline,
                          "label": TTexts.occupation.tr,
                          "value": "Not working"
                        },
                      ],
                      primaryColor,
                    ),
                    _infoCard(
                      TTexts.socioReligious.tr,
                      Icons.account_balance,
                      [
                        {
                          "icon": Icons.self_improvement,
                          "label": TTexts.religion.tr,
                          "value": "Hindu"
                        },
                        {
                          "icon": Icons.groups,
                          "label": TTexts.caste.tr,
                          "value": "Vanniar"
                        },
                        {
                          "icon": Icons.star_rate,
                          "label": TTexts.star.tr,
                          "value": "சித்ரை - 1ம் பாதம்"
                        },
                        {
                          "icon": Icons.wb_sunny,
                          "label": TTexts.lagnam.tr,
                          "value": "கடகம்"
                        },
                      ],
                      primaryColor,
                    ),
                    _infoCard(
                      TTexts.physicalStatus.tr,
                      Icons.accessibility_new,
                      [
                        {
                          "icon": Icons.height,
                          "label": TTexts.height.tr,
                          "value": "5ft 3in (160cm)"
                        },
                        {
                          "icon": Icons.face_retouching_natural,
                          "label": TTexts.complexion.tr,
                          "value": "Medium"
                        },
                      ],
                      primaryColor,
                    ),
                    _infoCard(
                      TTexts.familyDetails.tr,
                      Icons.family_restroom,
                      [
                        {
                          "icon": Icons.man,
                          "label": TTexts.father.tr,
                          "value": "செந்தில்குமார் (Private)"
                        },
                        {
                          "icon": Icons.woman,
                          "label": TTexts.mother.tr,
                          "value": "கோவிந்தி (Housewife)"
                        },
                        {
                          "icon": Icons.people,
                          "label": TTexts.siblings.tr,
                          "value": "0 Brothers | 0 Sisters"
                        },
                      ],
                      primaryColor,
                    ),
                    _infoCard(
                      TTexts.partnerPreference.tr,
                      Icons.favorite_border,
                      [
                        {
                          "icon": Icons.groups_2,
                          "label": TTexts.caste.tr,
                          "value": "Vanniar"
                        },
                      ],
                      primaryColor,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download),
                            label: Text(TTexts.downloadHoroscope.tr),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.favorite),
                            label: Text(TTexts.showInterest.tr),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Info card widget
  static Widget _infoCard(String title, IconData icon,
      List<Map<String, dynamic>> details, Color primaryColor) {
    return TRoundedContainer(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: primaryColor, size: 26),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 20, thickness: 1.2),
          ...details.map(
                (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item["icon"], size: 22, color: Colors.grey[700]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["label"],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item["value"],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
