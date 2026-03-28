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
          imageProvider: (imageType == ImageType.network &&
                  imageUrl.isNotEmpty &&
                  imageUrl != "null" &&
                  imageUrl.startsWith('http'))
              ? CachedNetworkImageProvider(imageUrl)
              : AssetImage(imageUrl.isEmpty || imageUrl == "null"
                      ? TImages.defaultProfilePic
                      : imageUrl) as ImageProvider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 3,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          errorBuilder: (context, error, stackTrace) => Center(
            child: Image.asset(TImages.defaultProfilePic),
          ),
        ),
      ),
    );
  }
}
