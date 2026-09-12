import 'dart:io';

import '../../../../../utils/constants/path_provider.dart';

class ImagePickerBox extends StatelessWidget {
  final String title;
  final RxString imagePath; // can be URL or local path
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

  bool _isPdf(String path) => path.toLowerCase().endsWith('.pdf');

  bool _isNetworkImage(String path) =>
      path.startsWith('http://') || path.startsWith('https://');

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
        Obx(() {
          final path = imagePath.value;

          return GestureDetector(
            onTap: onPickImage, // always allow update
            child: Container(
              width: double.infinity,
              height: _isPdf(path) ? 80 : 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: path.isEmpty
                  ? _buildPlaceholder(theme, color)
                  : Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildPreview(path),
                        ),
                        _buildRemoveButton(),
                      ],
                    ),
            ),
          );
        }),
      ],
    );
  }

  /* ================================================================
   * PREVIEW HANDLER
   * ================================================================ */

  Widget _buildPreview(String path) {
    if (_isPdf(path)) {
      return _buildPdfPreview(path);
    }

    if (_isNetworkImage(path)) {
      return TRoundedImage(
        image: path,
        imageType: ImageType.network,
        width: double.infinity,
        height: double.infinity,
        borderRadius: 12,
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(path),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
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
          style: theme.bodyMedium?.copyWith(color: Colors.grey[600]),
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
          const Icon(Icons.picture_as_pdf, size: 48, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              path.split('/').last,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
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
          icon: const Icon(Icons.close, size: 18, color: Colors.white),
          onPressed: () => imagePath.value = '',
        ),
      ),
    );
  }
}
