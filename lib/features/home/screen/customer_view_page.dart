import 'package:tamilnadu_matrimony/common/widgets/images/image_preview_page.dart';
import 'package:tamilnadu_matrimony/features/home/model/customer_user_model.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';
import 'package:tamilnadu_matrimony/utils/helpers/url_launcher.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/horoscope/horoscope_chart.dart';
import '../controller/dashboard_controller.dart';

class CustomerDetailsView extends StatelessWidget {
  // final CustomerUserModel userModel;
  const CustomerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return Obx(() {
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
              tooltip: "Share Profile",
              onPressed: () {
                controller.shareProfile(userModel);
              },
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
                      imageUrl: userModel.photo1,
                      imageType: userModel.photo1 == ""
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
                    imageType: userModel.photo1 == ""
                        ? ImageType.asset
                        : ImageType.network,
                    image: userModel.photo1,
                    backgroundColor: TColors.white,
                    fit: BoxFit.fill,
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
                        userModel: userModel,
                        TTexts.basicInfo.tr,
                        Icons.person_outline,
                        [
                          {
                            'icon': Icons.numbers,
                            'label': TTexts.matriId.tr,
                            'value': userModel.matriId,
                          },
                          {
                            "icon": Icons.badge,
                            "label": TTexts.nameAge.tr,
                            "value": "${userModel.name}, ${userModel.age} yrs",
                          },
                          {
                            "icon": Icons.location_on,
                            "label": TTexts.location.tr,
                            "value": "${userModel.city}, ${userModel.state}",
                          },
                          {
                            "icon": Icons.favorite,
                            "label": TTexts.maritalStatus.tr,
                            "value": userModel.maritalStatus,
                          },
                          {
                            "icon": Icons.cake,
                            "label": TTexts.dob.tr,
                            "value": THelperFunctions.formatDateString(
                              userModel.dob,
                            ),
                          },
                        ],
                        primaryColor,
                        showLikeAndShare: true,
                      ),

                      /// EDUCATION & OCCUPATION
                      _infoCard(
                        userModel: userModel,
                        TTexts.educationOccupation.tr,
                        Icons.school_outlined,
                        [
                          {
                            "icon": Icons.menu_book,
                            "label": TTexts.degree.tr,
                            "value": userModel.educationDetails,
                          },
                          {
                            "icon": Icons.work_outline,
                            "label": TTexts.occupation.tr,
                            "value": userModel.occupation,
                          },
                        ],
                        primaryColor,
                      ),

                      /// SOCIO RELIGIOUS
                      _infoCard(
                        userModel: userModel,
                        TTexts.socioReligious.tr,
                        Icons.account_balance,
                        [
                          {
                            "icon": Icons.self_improvement,
                            "label": TTexts.religion.tr,
                            "value": userModel.religion,
                          },
                          {
                            "icon": Icons.groups,
                            "label": TTexts.caste.tr,
                            "value": userModel.caste,
                          },
                          {
                            "icon": Icons.star_rate,
                            "label": TTexts.star.tr,
                            "value": userModel.star,
                          },
                          {
                            "icon": Icons.wb_sunny,
                            "label": TTexts.lagnam.tr,
                            "value": userModel.inLaknam,
                          },
                          // if (userModel.doshamType != "")
                          {
                            "icon": Icons.warning_amber_rounded,
                            "label": "Dosham",
                            "value": userModel.doshamType,
                          },
                        ],
                        primaryColor,
                      ),

                      /// PHYSICAL DETAILS
                      _infoCard(
                        userModel: userModel,
                        TTexts.physicalStatus.tr,
                        Icons.accessibility_new,
                        [
                          {
                            "icon": Icons.height,
                            "label": TTexts.height.tr,
                            "value": userModel.height,
                          },
                          {
                            "icon": Icons.face_retouching_natural,
                            "label": TTexts.complexion.tr,
                            "value": userModel.complexion,
                          },
                          {
                            "icon": Icons.accessible,
                            "label": "Special Cases",
                            "value": userModel.speCases,
                          },
                        ],
                        primaryColor,
                      ),

                      /// FAMILY DETAILS
                      _infoCard(
                        userModel: userModel,
                        TTexts.familyDetails.tr,
                        Icons.family_restroom,
                        [
                          if (userModel.fatherName != "")
                            {
                              "icon": Icons.man,
                              "label": TTexts.father.tr,
                              "value":
                                  "${userModel.fatherName} - ${userModel.fathersOccupation}",
                            },
                          if (userModel.motherName != "")
                            {
                              "icon": Icons.woman,
                              "label": TTexts.mother.tr,
                              "value":
                                  "${userModel.motherName} - ${userModel.mothersOccupation}",
                            },
                          {
                            "icon": Icons.people,
                            "label": TTexts.siblings.tr,
                            "value":
                                "${userModel.noOfBrothers} Brothers | ${userModel.noOfSisters} Sisters",
                          },
                        ],
                        primaryColor,
                      ),

                      /// CONTACT DETAILS (ONLY IF UNLOCKED)
                      if (userModel.isUnlocked)
                        _infoCard(
                          userModel: userModel,
                          TTexts.contactDetails.tr,
                          Icons.contact_phone,
                          [
                            {
                              "icon": Icons.call,
                              "label": TTexts.mobileNo.tr,
                              "value": userModel.mobile.isEmpty
                                  ? "-"
                                  : userModel.mobile,
                              "onTap": (userModel.mobile.isNotEmpty && userModel.mobile != "-")
                                  ? () => TUrlLauncher.callPhone(userModel.mobile)
                                  : null,
                            },
                            {
                              "icon": Icons.phone,
                              "label": TTexts.phone.tr,
                              "value": userModel.phone.isEmpty
                                  ? "-"
                                  : userModel.phone,
                              "onTap": (userModel.phone.isNotEmpty && userModel.phone != "-")
                                  ? () => TUrlLauncher.callPhone(userModel.phone)
                                  : null,
                            },
                            {
                              "icon": Icons.home,
                              "label": TTexts.address.tr,
                              "value": userModel.address.isEmpty
                                  ? "-"
                                  : userModel.address,
                            },
                          ],
                          primaryColor,
                        ),

                      /// PARTNER PREFERENCE PLACEHOLDER
                      if (userModel.expectations != "")
                        _infoCard(
                          userModel: userModel,
                          TTexts.partnerPreference.tr,
                          Icons.favorite_border,
                          [
                            if (userModel.expectations != "")
                              {
                                "icon": Icons.comment_outlined,
                                "label": "Expectations",
                                "value": userModel.expectations,
                              },
                          ],
                          primaryColor,
                        ),

                      /// Horoscope Section
                      if (userModel.horosCheck.isNotEmpty &&
                          userModel.horosApprove.toLowerCase() == "yes")
                        //   SizedBox(
                        //     width: double.infinity,
                        //     child: ElevatedButton.icon(
                        //       onPressed: () {
                        //         Get.to(
                        //           () => ImagePreviewPage(
                        //             imageUrl: userModel.horosCheck,
                        //             imageType: ImageType.network,
                        //           ),
                        //         );
                        //       },
                        //       icon: const Icon(Icons.remove_red_eye),
                        //       label: Text(TTexts.horoscope.tr),
                        //     ),
                        //   )
                        SizedBox()
                      else
                        HoroscopeChart(
                          rasiData: userModel.rasi,
                          amsamData: userModel.amsam,
                        ),
                      SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: userModel.isUnlocked
            ? null
            : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      controller.unlockProfile(
                        profileId: userModel.id,
                        unlockValue: userModel.isUnlocked.toString().obs,
                        navigateToView: false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.lock_open_rounded),
                    label: Text(
                      TTexts.unlockNumber.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }

  /// ---------------------- Info Card Widget ------------------------
  static Widget _infoCard(
    String title,
    IconData icon,
    List<Map<String, dynamic>> details,
    Color primaryColor, {
    required CustomerUserModel userModel,
    bool showLikeAndShare = false,
  }) {
    final controller = DashboardController.instance;

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
                  color: primaryColor.withValues(alpha: 0.15),
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
                    Obx(
                      () => IconButton(
                        tooltip: "Like",
                        onPressed: () {
                          controller.likeProfile(
                            profileId: userModel.id,
                            likedValue: userModel.liked,
                          );
                        },
                        icon: controller.isLikeLoading.value
                            ? CircularProgressIndicator(color: Colors.red)
                            : userModel.liked.value.toLowerCase() == "yes"
                            ? Icon(Icons.favorite, color: TColors.error)
                            : Icon(Icons.favorite_border, color: TColors.error),
                        color: Colors.redAccent,
                        iconSize: 28,
                      ),
                    ),
                    IconButton(
                      tooltip: "Send Interest",
                      onPressed: () {
                        controller.sendRequestAPI(profileId: userModel.id);
                      },
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
            (item) {
              final VoidCallback? onTap = item["onTap"];
              
              Widget rowContent = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    item["icon"], 
                    size: 22, 
                    color: onTap != null ? primaryColor : Colors.grey[700],
                  ),
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
                          style: TextStyle(
                            fontSize: 14,
                            color: onTap != null ? primaryColor : Colors.black54,
                            fontWeight: onTap != null ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onTap != null) ...[
                    const SizedBox(width: 10),
                    Icon(
                      Icons.phone_forwarded_outlined,
                      size: 18,
                      color: primaryColor.withValues(alpha: 0.6),
                    ),
                  ],
                ],
              );

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: onTap != null
                    ? InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          child: rowContent,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        child: rowContent,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
