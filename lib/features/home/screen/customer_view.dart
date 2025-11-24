import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/common/widgets/images/image_preview_page.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../controller/dashboard_controller.dart';

class CustomerDetailsView extends StatelessWidget {
  // final CustomerUserModel userModel;
  const CustomerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    final userModel = controller.userModel.value;

    final primaryColor = TColors.primary;
    final secondaryColor = Colors.grey[100]!;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: TAppBar(
        title: TTexts.appName.tr,
        isBackButtonNeed: true,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.share_outlined),
            color: TColors.primary,
            iconSize: 26,
          ),
        ],
      ),

      /// Body
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Profile Image
              GestureDetector(
                onTap: () => Get.to(
                      () => ImagePreviewPage(
                    imageUrl: userModel.photo1 ?? TImages.sampleUser,
                    imageType: userModel.photo1 == null
                        ? ImageType.asset
                        : ImageType.network,
                  ),
                ),
                child: TRoundedImage(
                  width: double.infinity,
                  height: 400,
                  margin: 0,
                  padding: 0,
                  borderRadius: 0,
                  imageType: userModel.photo1 == null
                      ? ImageType.asset
                      : ImageType.network,
                  image: userModel.photo1 ?? TImages.sampleUser,
                  backgroundColor: TColors.white,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// All Info Sections
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    /// BASIC INFO
                    _infoCard(
                      TTexts.basicInfo.tr,
                      Icons.person_outline,
                      [
                        {
                          "icon": Icons.badge,
                          "label": TTexts.nameAge.tr,
                          "value": "${userModel.name ?? ''}, ${userModel.age ?? ''} yrs"
                        },
                        {
                          "icon": Icons.location_on,
                          "label": TTexts.location.tr,
                          "value": "${userModel.city ?? ''}, ${userModel.state ?? ''}"
                        },
                        {
                          "icon": Icons.favorite,
                          "label": TTexts.maritalStatus.tr,
                          "value": userModel.maritalStatus ?? "-"
                        },
                        {
                          "icon": Icons.cake,
                          "label": TTexts.dob.tr,
                          "value": userModel.dob ?? "-"
                        },
                      ],
                      primaryColor,
                      showLikeAndShare: true,
                    ),

                    /// EDUCATION & OCCUPATION
                    _infoCard(
                      TTexts.educationOccupation.tr,
                      Icons.school_outlined,
                      [
                        {
                          "icon": Icons.menu_book,
                          "label": TTexts.degree.tr,
                          "value": userModel.educationDetails ?? "-"
                        },
                        {
                          "icon": Icons.work_outline,
                          "label": TTexts.occupation.tr,
                          "value": userModel.occupation ?? "-"
                        },
                      ],
                      primaryColor,
                    ),

                    /// SOCIO RELIGIOUS
                    _infoCard(
                      TTexts.socioReligious.tr,
                      Icons.account_balance,
                      [
                        {
                          "icon": Icons.self_improvement,
                          "label": TTexts.religion.tr,
                          "value": userModel.religion ?? "-"
                        },
                        {
                          "icon": Icons.groups,
                          "label": TTexts.caste.tr,
                          "value": userModel.caste ?? "-"
                        },
                        {
                          "icon": Icons.star_rate,
                          "label": TTexts.star.tr,
                          "value": userModel.star ?? "-"
                        },
                        {
                          "icon": Icons.wb_sunny,
                          "label": TTexts.lagnam.tr,
                          "value": userModel.inLaknam ?? "-"
                        },
                      ],
                      primaryColor,
                    ),

                    /// PHYSICAL DETAILS
                    _infoCard(
                      TTexts.physicalStatus.tr,
                      Icons.accessibility_new,
                      [
                        {
                          "icon": Icons.height,
                          "label": TTexts.height.tr,
                          "value": userModel.height ?? "-"
                        },
                        {
                          "icon": Icons.face_retouching_natural,
                          "label": TTexts.complexion.tr,
                          "value": userModel.complexion ?? "-"
                        },
                      ],
                      primaryColor,
                    ),

                    /// FAMILY DETAILS
                    _infoCard(
                      TTexts.familyDetails.tr,
                      Icons.family_restroom,
                      [
                        {
                          "icon": Icons.man,
                          "label": TTexts.father.tr,
                          "value":
                          "${userModel.fatherName ?? ''} (${userModel.fathersOccupation ?? ''})"
                        },
                        {
                          "icon": Icons.woman,
                          "label": TTexts.mother.tr,
                          "value":
                          "${userModel.motherName ?? ''} (${userModel.mothersOccupation ?? ''})"
                        },
                        {
                          "icon": Icons.people,
                          "label": TTexts.siblings.tr,
                          "value":
                          "${userModel.noOfBrothers ?? '0'} Brothers | ${userModel.noOfSisters ?? '0'} Sisters"
                        },
                      ],
                      primaryColor,
                    ),

                    /// PARTNER PREFERENCE PLACEHOLDER
                    _infoCard(
                      TTexts.partnerPreference.tr,
                      Icons.favorite_border,
                      [
                        {
                          "icon": Icons.groups_2,
                          "label": TTexts.caste.tr,
                          "value": userModel.caste ?? "-"
                        },
                      ],
                      primaryColor,
                    ),

                    /// Horoscope Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                        label: Text(TTexts.horoscope.tr),
                      ),
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

  /// ---------------------- Info Card Widget ------------------------
  static Widget _infoCard(
      String title,
      IconData icon,
      List<Map<String, dynamic>> details,
      Color primaryColor, {
        bool showLikeAndShare = false,
      }) {
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
              const Spacer(),
              if (showLikeAndShare)
                Row(
                  children: [
                    IconButton(
                      tooltip: "Like",
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.redAccent,
                      iconSize: 28,
                    ),
                    IconButton(
                      tooltip: "Send Interest",
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                      color: Colors.blueAccent,
                      iconSize: 26,
                    ),
                  ],
                ),
            ],
          ),

          const Divider(height: 20, thickness: 1.2),

          /// Detail rows
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
                        Text(item["label"],
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                        const SizedBox(height: 2),
                        Text(item["value"],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54)),
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
