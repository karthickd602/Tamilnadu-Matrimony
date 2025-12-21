import 'dart:io';

import '../../../common/widgets/images/t_image_picker.dart';
import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../repository/profile_repository.dart';

class VerifyProfileController extends GetxController {
  final documentPath = "".obs;
  final documentFile = File('').obs;
  final isLoading = false.obs;
  final storage = GetStorage();
  final repo = Get.put(ProfileRepository());

  void selectDocument(BuildContext context) async {
    final file = await TImagePickerHelper.pickIdentityCard(context);
    if (file != null) {
      documentFile.value = file;
      documentPath.value = file.path;
    }
  }

  Future<void> updateVerifyDocument() async {
    try {

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        return ;
      }
      isLoading.value = true;
      TFullScreenLoader.popUpCircular();
      if (documentPath.value == '') {
        return TLoaders.errorSnackBar(
          title: "Upload Failed",
          message: "Please select document",
        );
      }
      final userId = storage.read(TTexts.userId);

      final response = await repo.updateVerifyDocument(
        userId: userId,
        imageFile: documentFile.value,
      );

      TLoaders.successSnackBar(
        title: "Profile Updated",
        message: response['message'],
      );

      documentFile.value= File('');
      documentPath.value = '';
    } catch (e) {
      TLoaders.errorSnackBar(title: "Upload Failed", message: e.toString());
    } finally {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
    }
  }
}
