import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

import '../../../utils/constants/path_provider.dart';

class ImagePreviewPage extends StatelessWidget {
  final String imageUrl;
  final ImageType? imageType;
  const ImagePreviewPage({
    super.key,
    required this.imageUrl,
    this.imageType = ImageType.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: imageType == ImageType.network
              ? CachedNetworkImageProvider(imageUrl)
              : AssetImage(imageUrl) as ImageProvider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 3,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.broken_image, color: Colors.white, size: 80),
                const SizedBox(height: 16),
                Text(
                  "Image not found",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
