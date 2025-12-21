import 'dart:io';

import '../../../utils/constants/path_provider.dart';

class ProfileRepository extends GetxController {
  static ProfileRepository get instance => Get.find();

  final storage = GetStorage();

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

    final request = {"id": userId};

    return await THttpHelper.post(ApiConstant.viewUserProfileEndpoint, request);
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

    final request = {"user_id": userId};

    return await THttpHelper.multipartPost(
      ApiConstant.updateUserPhotoEndpoint,
      request,
      filePath: imageFile.path,
      fileFieldName: "file",
    );
  }

  Future<Map<String, dynamic>> updateVerifyDocument({
    required String userId,
    required File imageFile,
  }) async {
    final request = {"user_id": userId};

    return await THttpHelper.multipartPost(
      ApiConstant.updateVerifyDocumentEndpoint,
      request,
      filePath: imageFile.path,
      fileFieldName: "file",
    );
  }

  Future<Map<String, dynamic>> deleteProfile({required String reason}) async {
    final request = {"id": storage.read(TTexts.userId), "message": reason};
    debugPrint("Delete Profile Request : $request");
    final response = await THttpHelper.post(
      ApiConstant.deleteProfileEndpoint,
      request,
    );
    debugPrint("Delete Profile Response : $response");
    return response;
  }
}
