import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';

import '../../../../common/widgets/images/image_preview_page.dart';
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
      appBar: const TAppBar(title: "My Profile", isBackButtonNeed: true),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
            return const Center(child: Text("No profile data"));
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
                    title: "Basic Information",
                    children: [
                      _info("Name", profile.name),
                      _info("Matri ID", profile.matriId),
                      _info("Age", profile.age),
                      _info("Gender", profile.gender),
                      _info("Date of Birth", profile.dob),
                      _info("Height", profile.height),
                      _info("Complexion", profile.complexion),
                      _info("Marital Status", profile.maritalStatus),
                      _info("Religion", profile.religion),
                      _info("Caste", profile.caste),
                      _info("Sub Caste", profile.subCaste),
                    ],
                  ),

                  /// EDUCATION & PROFESSION
                  _SectionCard(
                    title: "Education & Profession",
                    children: [
                      _info("Education", profile.educationDetails),
                      _info("Occupation", profile.occupation),
                      _info("Occupation Details", profile.occupationDetails),
                      _info(
                        "Annual Income",
                        profile.annualIncome != null
                            ? "₹ ${profile.annualIncome}"
                            : null,
                      ),
                      _info("Workplace", profile.workplace),
                    ],
                  ),

                  /// FAMILY
                  _SectionCard(
                    title: "Family Details",
                    children: [
                      _info("Father Name", profile.fatherName),
                      _info("Father Occupation", profile.fathersOccupation),
                      _info("Mother Name", profile.motherName),
                      _info("Mother Occupation", profile.mothersOccupation),
                      _info("Family Status", profile.familyStatus),
                      _info("Brothers", profile.noOfBrothers),
                      _info("Sisters", profile.noOfSisters),
                      _info(
                        "Children Living Status",
                        profile.childrenLivingStatus,
                      ),
                    ],
                  ),

                  /// LOCATION
                  _SectionCard(
                    title: "Location",
                    children: [
                      _info("Country", profile.country),
                      _info("State", profile.state),
                      _info("City", profile.city),
                      _info("Postal Code", profile.postal),
                      const SizedBox(height: 6),
                      Text(
                        profile.address?.isNotEmpty == true
                            ? profile.address!
                            : "-",
                        style: const TextStyle(fontSize: 14, height: 1.6),
                      ),
                    ],
                  ),

                  /// CONTACT
                  _SectionCard(
                    title: "Contact Information",
                    children: [
                      _info("Phone", profile.phone),
                      _info("Mobile", profile.mobile),
                      _info("Email", profile.confirmEmail),
                    ],
                  ),

                  /// HOROSCOPE
                  _SectionCard(
                    title: "Horoscope Details",
                    children: [
                      _info("Moon Sign", profile.moonsign),
                      _info("Star", profile.star),
                      _info("Dasa Type", profile.dasaType),
                      _info("Thosam", profile.thosam),
                      _info("Thosam Type", profile.thoosamType),
                      _info("Laknam", profile.inLaknam),
                      _info(
                        "Horoscope Status",
                        profile.horosApprove == "Yes" ? "Approved" : "Pending",
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
                CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: profile.photo1?.isNotEmpty == true
                      ? NetworkImage(profile.photo1!)
                      : null,
                  child: profile.photo1?.isEmpty == true
                      ? const Icon(Icons.person, size: 42)
                      : null,
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
                  "Matri ID : ${profile.matriId}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _statusChip(
                      profile.verified == "yes" ? "Verified" : "Not Verified",
                      profile.verified == "yes" ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    _statusChip(
                      profile.photo1Approve == "Yes"
                          ? "Photo Approved"
                          : "Photo Pending",
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
