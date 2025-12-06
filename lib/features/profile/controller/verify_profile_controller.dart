import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/path_provider.dart';

class VerifyProfileController extends GetxController{


  final documentPath ="".obs;


  Future<void> pickImage(ImageSource source,{required RxString imagePath}) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      imagePath.value = picked.path;
    }
  }
  void showImageSourceSheet({required RxString imagePath}) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera,imagePath: imagePath);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () {
                  pickImage(ImageSource.gallery,imagePath: imagePath);
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}