import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePickerBox extends StatelessWidget {
  final String title;
  final RxString imagePath;
  final VoidCallback onPickImage;
  final Color? primaryColor;
  final TextTheme? textTheme;

  const ImagePickerBox({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPickImage,
    this.primaryColor,
    this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = textTheme ?? Theme.of(context).textTheme;
    final color = primaryColor ?? Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: theme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 8),

        /// Image container with preview
        Obx(
              () => GestureDetector(
            onTap: onPickImage,
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: imagePath.value.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    size: 42,
                    color: color,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tap to upload".tr,
                    style: theme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              )
                  : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imagePath.value),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: () => imagePath.value = '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
