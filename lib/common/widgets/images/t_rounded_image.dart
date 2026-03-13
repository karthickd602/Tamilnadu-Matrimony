import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../shimmers/shimmer.dart'; // your shimmer widget

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    required this.imageType,
    required this.image,
    this.file,
    this.memoryImage,
    this.borderRadius = TSizes.md,
    this.width = 56,
    this.height = 56,
    this.fit = BoxFit.cover,
    this.applyRadius = true,
    this.border,
    this.backgroundColor,
    this.margin,
    this.padding = TSizes.sm,
  });

  final String image;
  final File? file;
  final Uint8List? memoryImage;
  final ImageType imageType;

  final double width;
  final double height;
  final double borderRadius;
  final bool applyRadius;
  final double padding;
  final double? margin;

  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: applyRadius
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        child: _buildImage(),
      ),
    );
  }

  /// MAIN IMAGE BUILDER
  Widget _buildImage() {
    switch (imageType) {
      case ImageType.network:
        return _networkImage();
      case ImageType.file:
        return _fileImage();
      case ImageType.memory:
        return _memoryImage();
      case ImageType.asset:
        return _assetImage();
    }
  }

  // -----------------------------
  // NETWORK IMAGE (Shimmer + Fade)
  // -----------------------------
  Widget _networkImage() {
    if (image.isEmpty ||
        image == "null" ||
        image == "default" ||
        !image.startsWith('http')) {
      return _fallbackImage();
    }

    return CachedNetworkImage(
      fit: fit,
      imageUrl: image,
      progressIndicatorBuilder: (_, __, downloadProgress) =>
          TShimmerEffect(width: width, height: height),
      errorWidget: (context, url, error) {
        debugPrint("Image Load Error: $url - $error");
        return _fallbackImage();
      },
      memCacheHeight:
          (height > 0 && height.isFinite) ? (height * 3).toInt() : null,
      memCacheWidth:
          (width > 0 && width.isFinite) ? (width * 3).toInt() : null,
    );
  }

  // -----------------------------
  // FILE IMAGE
  // -----------------------------
  Widget _fileImage() {
    if (file == null) return _fallbackImage();
    return _fadeIn(Image.file(file!, fit: fit));
  }

  // -----------------------------
  // MEMORY IMAGE
  // -----------------------------
  Widget _memoryImage() {
    if (memoryImage == null) return _fallbackImage();
    return _fadeIn(Image.memory(memoryImage!, fit: fit));
  }

  // -----------------------------
  // ASSET IMAGE
  // -----------------------------
  Widget _assetImage() {
    return _fadeIn(Image.asset(image, fit: fit));
  }

  // -----------------------------
  // FADE-IN ANIMATION
  // -----------------------------
  Widget _fadeIn(Widget child) {
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
      child: child,
    );
  }

  // -----------------------------
  // FALLBACK DEFAULT IMAGE
  // -----------------------------
  Widget _fallbackImage() {
    return Image.asset(TImages.defaultProfilePic, fit: BoxFit.cover);
  }
}
