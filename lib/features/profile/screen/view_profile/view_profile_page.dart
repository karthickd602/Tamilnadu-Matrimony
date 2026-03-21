import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';

import '../../../../common/widgets/images/image_preview_page.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/images/t_image_picker.dart';
import '../../../../utils/constants/path_provider.dart';
import '../../controller/profile_controller.dart';
import '../../model/user_profile_model.dart';

class ViewProfilePage extends StatelessWidget {
  ViewProfilePage({super.key});

  final ProfileController controller = ProfileController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE8A3),
      appBar: TAppBar(title: TTexts.profileDetails.tr, isBackButtonNeed: true),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: Text(
                TTexts.editProfile.tr,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => Get.toNamed(TRoutes.editProfile),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final FetchUserProfileModel? profile = controller.userProfile.value;

          if (profile == null) {
            return Center(child: Text(TTexts.noProfileData.tr));
          }

          return RefreshIndicator(
            onRefresh: () {
              return controller.fetchUserProfile();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// PROFILE HEADER
                  _ProfileHeader(profile: profile, controller: controller),
                  const SizedBox(height: 18),

                  /// BASIC INFO
                  _SectionCard(
                    title: TTexts.basicInfo.tr,
                    children: [
                      _info(TTexts.name.tr, profile.name),
                      _info(TTexts.matriId.tr, profile.matriId),
                      _info(TTexts.age.tr, profile.age.toString()),
                      _info(
                        TTexts.gender.tr,
                        profile.gender == '1'
                            ? TTexts.male.tr
                            : TTexts.female.tr,
                      ),
                      _info(TTexts.dob.tr, profile.dob),
                      _info(TTexts.height.tr, profile.height),
                      _info(TTexts.complexion.tr, profile.complexion),
                      _info(TTexts.maritalStatus.tr, profile.maritalStatus),
                      _info(TTexts.religion.tr, profile.religion),
                      _info(TTexts.partnerCaste.tr, profile.caste),
                      _info(TTexts.subCaste.tr, profile.subCaste),
                      _info(
                        TTexts.noCaste.tr,
                        profile.noCaste == "no_caste"
                            ? TTexts.yes.tr
                            : TTexts.no.tr,
                      ),
                      _info(
                        TTexts.disablePerson.tr,
                        profile.speCases == "1" ? TTexts.yes.tr : TTexts.no.tr,
                      ),
                      _info(TTexts.expectation.tr, profile.expections),
                    ],
                  ),

                  /// EDUCATION & PROFESSION
                  _SectionCard(
                    title: TTexts.educationOccupation.tr,
                    children: [
                      _info(TTexts.education.tr, profile.educationDetails),
                      _info(TTexts.occupation.tr, profile.occupation),
                      _info(
                        TTexts.occupationDetails.tr,
                        profile.occupationDetails,
                      ),
                      _info(TTexts.workplace.tr, profile.workplace),
                      _info(
                        TTexts.income.tr,
                        profile.annualIncome != null
                            ? "₹ ${profile.annualIncome}"
                            : null,
                      ),
                      // _info("Workplace", profile.workplace),
                    ],
                  ),

                  /// FAMILY
                  _SectionCard(
                    title: TTexts.familyDetails.tr,
                    children: [
                      _info(TTexts.fatherName.tr, profile.fatherName),
                      _info(
                        TTexts.fatherOccupation.tr,
                        profile.fathersOccupation,
                      ),
                      _info(TTexts.motherName.tr, profile.motherName),
                      _info(
                        TTexts.motherOccupation.tr,
                        profile.mothersOccupation,
                      ),
                      _info(TTexts.familyStatus.tr, profile.familyStatus),
                      _info(TTexts.brothers.tr, profile.noOfBrothers),
                      _info(TTexts.sisters.tr, profile.noOfSisters),
                      _info(
                        TTexts.childrenLivingStatus.tr,
                        profile.childrenLivingStatus,
                      ),
                      _info(TTexts.nativePlace.tr, profile.irupidam),
                      _info(TTexts.marriedBrothers.tr, profile.nbm),
                      _info(TTexts.marriedSisters.tr, profile.nsm),
                    ],
                  ),

                  /// LOCATION
                  _SectionCard(
                    title: TTexts.location.tr,
                    children: [
                      _info(TTexts.country.tr, profile.country),
                      _info(TTexts.state.tr, profile.state),
                      _info(TTexts.city.tr, profile.city),
                      _info(TTexts.postalCode.tr, profile.postal),
                      // const SizedBox(height: 6),
                      _info(TTexts.address.tr, profile.address),
                    ],
                  ),

                  /// CONTACT
                  _SectionCard(
                    title: TTexts.contactDetailsTitle.tr,
                    children: [
                      _info(TTexts.phone.tr, profile.phone),
                      _info(TTexts.mobileNumber.tr, profile.mobile),
                      _info(TTexts.email.tr, profile.confirmEmail),
                    ],
                  ),

                  /// HOROSCOPE
                  _SectionCard(
                    title: TTexts.horoscopeDetailsTitle.tr,
                    children: [
                      _info(TTexts.rasi.tr, profile.moonsign),
                      _info(TTexts.star.tr, profile.star),
                      _info(TTexts.dasaType.tr, profile.dasaType),
                      _info(TTexts.dosham.tr, profile.thosam),
                      _info(TTexts.thosamType.tr, profile.thoosamType),
                      _info(TTexts.lagnam.tr, profile.inLaknam),
                      _info(
                        TTexts.horoscopeStatus.tr,
                        profile.horosApprove == "Yes"
                            ? TTexts.approved.tr
                            : TTexts.pending.tr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  /// COMMON INFO ROW
  static Widget _info(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: TSizes.xs),
          Expanded(
            flex: 5,
            child: Text(
              value?.trim().isNotEmpty == true ? value! : "-",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= PROFILE HEADER =================

class _ProfileHeader extends StatelessWidget {
  final FetchUserProfileModel profile;
  final ProfileController controller;

  const _ProfileHeader({required this.profile, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(TSizes.md),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(
                () => ImagePreviewPage(
                  imageUrl: profile.photo1 ?? '',
                  imageType: ImageType.network,
                ),
              );
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                TCircularImage(
                  width: 88,
                  height: 88,
                  backgroundColor: Colors.transparent,
                  imageType: profile.photo1?.isNotEmpty == true
                      ? ImageType.network
                      : ImageType.asset,
                  image: profile.photo1?.isNotEmpty == true
                      ? profile.photo1!
                      : TImages.defaultProfilePic,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () async {
                      final file = await TImagePickerHelper.pickProfilePhoto(
                        context,
                      );
                      if (file != null) {
                        controller.updateProfileImage(file);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: TSizes.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${TTexts.matriId.tr} : ${profile.matriId}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _statusChip(
                      profile.verified == "yes"
                          ? TTexts.verified.tr
                          : TTexts.notVerified.tr,
                      profile.verified == "yes" ? Colors.green : Colors.orange,
                    ),
                    _statusChip(
                      profile.photo1Approve == "Yes"
                          ? TTexts.photoApproved.tr
                          : TTexts.photoPending.tr,
                      Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// ================= SECTION CARD =================

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
