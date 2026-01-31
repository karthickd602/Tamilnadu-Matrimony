import 'dart:io';

import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../model/user_profile_model.dart';
import '../repository/profile_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final storage = GetStorage();
  final repo = Get.put(ProfileRepository());
  final isLoading = false.obs;
  final isUpdateProfileLoading = false.obs;

  final userProfile = Rxn<FetchUserProfileModel>();
  final pickedImage = Rxn<File>();

  /* ========================================================
   *  FETCH USER PROFILE
   * ======================================================== */
  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      debugPrint("-----------------${storage.read(TTexts.userId)}");

      final userId = storage.read(TTexts.userId);
      final response = await repo.fetchUserProfile(userId: userId);
      debugPrint("Profile Response : $response");
      userProfile.value = FetchUserProfileModel.fromJson(response["data"]);
    } catch (e) {
      debugPrint("Profile Error : $e");
      TLoaders.errorSnackBar(title: "Profile Error", message: e.toString());
    } finally {
      isLoading.value = false;
      // TFullScreenLoader.stopLoading();
    }
  }

  /* ========================================================
   *  UPDATE PROFILE IMAGE
   * ======================================================== */
  Future<void> updateProfileImage(File file) async {
    try {
      isUpdateProfileLoading.value = true;
      TFullScreenLoader.popUpCircular();

      final userId = storage.read(TTexts.userId);

      final response = await repo.updateProfileImage(
        userId: userId,
        imageFile: file,
      );

      TLoaders.successSnackBar(
        title: "Profile Updated",
        message: response['message'],
      );

      await fetchUserProfile();
    } catch (e) {
      TLoaders.errorSnackBar(title: "Upload Failed", message: e.toString());
    } finally {
      isUpdateProfileLoading.value = false;
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> deleteProfile({required String reason}) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      TFullScreenLoader.popUpCircular();

      final response = await repo.deleteProfile(reason: reason);
      TLoaders.successSnackBar(
        title: "Profile Deleted",
        message: response['message'],
      );
      await storage.remove(TTexts.userId);
      await storage.erase();
      TFullScreenLoader.stopLoading();

      Get.offAllNamed(TRoutes.languageSelection);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Delete Failed", message: e.toString());
    }
  }
}
