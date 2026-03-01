import '../../utils/constants/path_provider.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize SplashController
    Get.put(SplashController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFF254),
        body: Stack(
          children: [
            // Full Screen Background Image
            Center(
              child: SizedBox(
                width: Get.width / 1.2,
                height: Get.height / 1.2,
                child: Image.asset(TImages.splashScreen, fit: BoxFit.fill),
              ),
            ),

            // Optional: Subtle Gradient Overlay from Bottom to ensure visibility if text is added
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.4),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Loading Indicator
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   "Tamilnadu Matrimony",
                    //   style: Theme.of(context).textTheme.headlineSmall
                    //       ?.copyWith(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //         letterSpacing: 2.0,
                    //       ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
