import 'dart:io';

import 'package:flutter/services.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/path_provider.dart';

class TImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /* ================================================================
   * PUBLIC METHODS
   * ================================================================ */

  /// 👤 PROFILE PHOTO (Image only)
  static Future<File?> pickProfilePhoto(BuildContext context) async {
    return _pickAndProcessImage(
      context,
      cropType: CropType.profile,
      allowPdf: false,
    );
  }

  /// 🪪 ID CARD (Image + PDF)
  static Future<File?> pickIdentityCard(BuildContext context) async {
    return _pickAndProcessImage(
      context,
      cropType: CropType.idCard,
      allowPdf: true,
    );
  }

  /* ================================================================
   * CORE PIPELINE
   * ================================================================ */

  static Future<File?> _pickAndProcessImage(
    BuildContext context, {
    required CropType cropType,
    required bool allowPdf,
  }) async {
    final PickedFileResult? picked = await _showPickerSheet(
      context,
      allowPdf: allowPdf,
    );

    if (picked == null) return null;

    /// ✅ PDF FLOW (ID CARD ONLY)
    if (picked.isPdf) {
      return picked.file;
    }

    /// IMAGE FLOW
    File? file = picked.file;

    file = await _cropImage(file, cropType);
    if (file == null) return null;

    if (!_isValidImage(file)) {
      TLoaders.errorSnackBar(
        title: "Invalid File",
        message: "Only JPG / JPEG / PNG images are allowed",
      );
      return null;
    }

    file = await _validateAndCompress(file);
    return file;
  }

  /* ================================================================
   * PICKER BOTTOM SHEET
   * ================================================================ */

  static Future<PickedFileResult?> _showPickerSheet(
    BuildContext context, {
    required bool allowPdf,
  }) {
    return Get.bottomSheet<PickedFileResult>(
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
                onTap: () async {
                  final picked = await _pickImage(ImageSource.camera);
                  if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

                  Get.back(
                    result: picked == null
                        ? null
                        : PickedFileResult.image(picked),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () async {
                  final picked = await _pickImage(ImageSource.gallery);
                  Get.back(
                    result: picked == null
                        ? null
                        : PickedFileResult.image(picked),
                  );
                },
              ),

              /// 🔥 PDF OPTION ONLY FOR ID CARD
              if (allowPdf)
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: const Text("Upload PDF"),
                  onTap: () async {
                    final pdf = await _pickPdf();
                    Get.back(
                      result: pdf == null ? null : PickedFileResult.pdf(pdf),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  /* ================================================================
   * IMAGE PICKER
   * ================================================================ */

  static Future<File?> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 100);
      return picked == null ? null : File(picked.path);
    } catch (e) {
      if (e is PlatformException && e.code == 'already_active') {
        // Ignore or handle concurrency issue gracefully
        return null;
      }
      rethrow;
    }
  }

  /* ================================================================
   * PDF PICKER
   * ================================================================ */

  static Future<File?> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    return result == null ? null : File(result.files.single.path!);
  }

  /* ================================================================
   * IMAGE CROP
   * ================================================================ */

  static Future<File?> _cropImage(File file, CropType type) async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio: type == CropType.profile
          ? const CropAspectRatio(ratioX: 1, ratioY: 1)
          : null,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: type == CropType.profile
              ? 'Crop Profile Photo'
              : 'Crop ID Card',
          lockAspectRatio: type == CropType.profile,
        ),
        IOSUiSettings(
          title: type == CropType.profile
              ? 'Crop Profile Photo'
              : 'Crop ID Card',
          aspectRatioLockEnabled: type == CropType.profile,
        ),
      ],
    );

    return cropped == null ? null : File(cropped.path);
  }

  /* ================================================================
   * VALIDATIONS
   * ================================================================ */

  static bool _isValidImage(File file) {
    final ext = file.path.split('.').last.toLowerCase();
    return ext == 'jpg' || ext == 'jpeg' || ext == 'png';
  }

  /* ================================================================
   * COMPRESSION
   * ================================================================ */

  static Future<File> _validateAndCompress(File file) async {
    const maxSizeMB = 2.0;
    double size = await _getFileSizeMB(file);
    int quality = 90;

    final ext = file.path.split('.').last.toLowerCase();
    final isPng = ext == 'png';
    final targetExt = isPng ? 'png' : 'jpg';

    while (size > maxSizeMB && quality > 20) {
      final compressed = await FlutterImageCompress.compressAndGetFile(
        file.path,
        "${file.path}_compressed.$targetExt",
        quality: quality,
      );

      file = File(compressed!.path);
      size = await _getFileSizeMB(file);
      quality -= 10;
    }

    return file;
  }

  static Future<double> _getFileSizeMB(File file) async {
    return (await file.length()) / (1024 * 1024);
  }
}

/* ================================================================
 * MODELS
 * ================================================================ */

enum CropType { profile, idCard }

class PickedFileResult {
  final File file;
  final bool isPdf;

  PickedFileResult.image(this.file) : isPdf = false;
  PickedFileResult.pdf(this.file) : isPdf = true;
}
