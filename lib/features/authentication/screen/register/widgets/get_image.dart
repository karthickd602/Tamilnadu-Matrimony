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

  bool _isPdf(String path) =>
      path.toLowerCase().endsWith('.pdf');

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

        /// Preview Container
        Obx(
              () => GestureDetector(
            onTap: onPickImage,
            child: Container(
              width: double.infinity,
              height:  _isPdf(imagePath.value)
                  ?80:180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: imagePath.value.isEmpty
                  ? _buildPlaceholder(theme, color)
                  : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _isPdf(imagePath.value)
                        ? _buildPdfPreview(imagePath.value)
                        : Image.file(
                      File(imagePath.value),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  _buildRemoveButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /* ================================================================
   * PLACEHOLDER
   * ================================================================ */

  Widget _buildPlaceholder(TextTheme theme, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_a_photo, size: 42, color: color),
        const SizedBox(height: 8),
        Text(
          "Tap to upload".tr,
          style: theme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /* ================================================================
   * PDF PREVIEW
   * ================================================================ */

  Widget _buildPdfPreview(String path) {
    return Container(
      color: Colors.red.shade50,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(
            Icons.picture_as_pdf,
            size: 48,
            color: Colors.red,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              path.split('/').last,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ================================================================
   * REMOVE BUTTON
   * ================================================================ */

  Widget _buildRemoveButton() {
    return Positioned(
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
    );
  }
}
