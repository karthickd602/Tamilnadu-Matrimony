import 'dart:io';


import '../../../utils/constants/path_provider.dart';

class ProfileRepository extends GetxController {
  static ProfileRepository get instance => Get.find();

  /* ========================================================
   *  FETCH USER PROFILE
   * ======================================================== */
  Future<Map<String, dynamic>> fetchUserProfile({
    required String userId,
  }) async {
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      throw Exception("No Internet Connection");
    }

    final request = {
      "id": userId,
    };

    return await THttpHelper.post(
      ApiConstant.viewUserProfileEndpoint,
      request,
    );
  }

  /* ========================================================
   *  UPDATE PROFILE IMAGE (MULTIPART)
   * ======================================================== */
  Future<Map<String, dynamic>> updateProfileImage({
    required String userId,
    required File imageFile,
  }) async {
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      throw Exception("No Internet Connection");
    }

    final request = {
      "user_id": userId,
    };

    return await THttpHelper.multipartPost(
      ApiConstant.updateUserPhotoEndpoint,
      request,
      filePath: imageFile.path,
      fileFieldName: "file",
    );
  }
}
