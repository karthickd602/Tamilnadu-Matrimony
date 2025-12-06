import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/path_provider.dart';

class TImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// =====================================================================
  ///  MAIN PUBLIC METHOD → Opens BottomSheet → Returns File After Validation
  /// =====================================================================
  static Future<File?> pickImageFromUser(BuildContext context) async {
    final source = await _showImagePickerSheet(context);
    if (source == null) return null;

    final file = await _pickImage(source);
    return file;
  }

  /// =====================================================================
  ///  REUSABLE BOTTOM SHEET → returns ImageSource?
  /// =====================================================================
  static Future<ImageSource?> _showImagePickerSheet(BuildContext context) async {
    return await Get.bottomSheet<ImageSource>(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () => Get.back(result: ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () => Get.back(result: ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =====================================================================
  /// PICK IMAGE + Validate + Compress (<2MB)
  /// =====================================================================
  static Future<File?> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 95,
      );

      if (picked == null) return null;

      File file = File(picked.path);

      /// Validate JPEG / JPG only
      if (!_isValidFileType(file)) {
        TLoaders.errorSnackBar(
          title: "Invalid File",
          message: "Only JPEG/JPG images are allowed.",
        );
        return null;
      }

      /// Validate & compress until < 2MB
      file = await _validateAndCompress(file);

      return file;
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Image Error",
        message: e.toString(),
      );
      return null;
    }
  }

  /// =====================================================================
  ///  VALIDATE FILE TYPE
  /// =====================================================================
  static bool _isValidFileType(File file) {
    final ext = file.path.split(".").last.toLowerCase();
    return ext == "jpg" || ext == "jpeg";
  }

  /// =====================================================================
  ///  COMPRESS IMAGE UNTIL < 2MB
  /// =====================================================================
  static Future<File> _validateAndCompress(File file) async {
    const maxSizeMB = 2.0;

    double sizeInMB = await _getFileSizeMB(file);

    while (sizeInMB > maxSizeMB) {
      final compressed = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        "${file.path}_compressed.jpg",
        quality: 70,
      );

      file = File(compressed!.path);
      sizeInMB = await _getFileSizeMB(file);
    }

    return file;
  }

  static Future<double> _getFileSizeMB(File file) async {
    final bytes = await file.length();
    return bytes / (1024 * 1024);
  }
}
