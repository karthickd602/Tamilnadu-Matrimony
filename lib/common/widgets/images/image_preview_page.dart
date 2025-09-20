
import 'package:photo_view/photo_view.dart';

import '../../../utils/constants/path_provider.dart';


class ImagePreviewPage extends StatelessWidget {
  final String imageUrl;
  final ImageType? imageType;
  const ImagePreviewPage({super.key, required this.imageUrl,  this.imageType= ImageType.asset});

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
          imageProvider:imageType==ImageType.network? NetworkImage(imageUrl):AssetImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 3,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
