import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/constants/path_provider.dart';
import '../shimmers/shimmer.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.memoryImage,
    this.backgroundColor,
    this.image,
    this.imageType = ImageType.asset,
    this.fit = BoxFit.cover,
    this.padding = TSizes.sm,
    this.file,
  });

  final BoxFit? fit;
  final String? image;
  final File? file;
  final ImageType imageType;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Uint8List? memoryImage;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white),
        borderRadius: BorderRadius.circular(width >= height ? width : height),
      ),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.file:
        imageWidget = _buildFileImage();
        break;
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    // Apply ClipRRect directly to the image widget
    return ClipRRect(
      borderRadius: BorderRadius.circular(width >= height ? width : height),
      child: imageWidget,
    );
  }

  // Function to build the network image widget
  Widget _buildNetworkImage() {
    if (image != null &&
        image!.isNotEmpty &&
        image != "null" &&
        image != "default" &&
        image!.startsWith('http')) {
      // Use CachedNetworkImage for efficient loading and caching of network images
      return CachedNetworkImage(
        fit: fit,
        color: overlayColor,
        imageUrl: image!,
        errorWidget: (context, url, error) {
          debugPrint("Image Load Error: $url - $error");
          return Image.asset(TImages.defaultProfilePic, fit: fit);
        },
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const TShimmerEffect(width: 55, height: 55),
        memCacheHeight:
            (height > 0 && height.isFinite) ? (height * 3).toInt() : null,
        memCacheWidth:
            (width > 0 && width.isFinite) ? (width * 3).toInt() : null,
      );
    } else {
      // Return fallback image if no valid image URL is provided
      return Image.asset(TImages.defaultProfilePic, fit: fit);
    }
  }

  // Function to build the memory image widget
  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      // Display image from memory using Image widget
      return Image(
        fit: fit,
        image: MemoryImage(memoryImage!),
        color: overlayColor,
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }

  // Function to build the asset image widget
  Widget _buildFileImage() {
    if (file != null) {
      // Display image from assets using Image widget
      return Image(fit: fit, image: FileImage(file!), color: overlayColor);
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }

  // Function to build the asset image widget
  Widget _buildAssetImage() {
    if (image != null) {
      // Display image from assets using Image widget
      return Image(fit: fit, image: AssetImage(image!), color: overlayColor);
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }
}
