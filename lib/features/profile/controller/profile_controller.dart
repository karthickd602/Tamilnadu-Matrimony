import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../model/user_profile_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final storage = GetStorage();
  final isLoading = false.obs;
  final isUpdateProfileLoading = false.obs;

  final userProfile = Rxn<FetchUserProfileModel>(null);
  final pickedImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  /* ========================================================
   *  FETCH USER PROFILE
   * ======================================================== */
  Future<void> fetchUserProfile() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Internet", message: "No Internet Connection");
        return;
      }

      TFullScreenLoader.popUpCircular();
      isLoading.value = true;

      final req = {"id": storage.read(TTexts.userId)};
      debugPrint("fetchUserProfile req: $req");

      final response =
      await THttpHelper.post(ApiConstant.viewUserProfileEndpoint, req);

      debugPrint("fetchUserProfile response: $response");

      userProfile.value = FetchUserProfileModel.fromJson(response["data"]);
    } catch (e) {
      debugPrint("fetchUserProfile Error: $e");
      TLoaders.errorSnackBar(
        title: "Error loading profile",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
    }
  }


  /* ========================================================
   *  UPLOAD PROFILE IMAGE (MULTIPART)
   * ======================================================== */
  Future<void> updateProfileImage(File file) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Internet", message: "No Internet Connection");
        return;
      }

      TFullScreenLoader.popUpCircular();
      isUpdateProfileLoading.value = true;

      final req = {"user_id": storage.read(TTexts.userId)};

      final response = await THttpHelper.multipartPost(
        ApiConstant.updateUserPhotoEndpoint,
        req,
        filePath: file.path,
        fileFieldName: "file",
      );

      debugPrint("updateProfileImage => $response");

      TLoaders.successSnackBar(
        title: "Profile Updated",
        message: response['message'],
      );

      await fetchUserProfile();
    } catch (e) {
      debugPrint("Upload Error: $e");
      TLoaders.errorSnackBar(
        title: "Upload Failed",
        message: e.toString(),
      );
    } finally {
      isUpdateProfileLoading.value = false;
      TFullScreenLoader.stopLoading();
    }
  }

  /* ========================================================
   *  DELETE PROFILE (Future Use)
   * ======================================================== */
  Future<void> deleteProfile() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: "No Internet", message: "No Internet Connection");
      }

      final req = {"user_id": storage.read(TTexts.userId)};

      // TODO → Call your delete API
    } catch (e) {
      debugPrint("deleteProfile Error: $e");
    }
  }
}
