import 'package:lottie/lottie.dart';
import '../../utils/constants/path_provider.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize SplashController
    Get.put(SplashController());

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  TColors.green, // Primary brand color
                  Color(0xFF1B5E20), // Darker shade for depth
                ],
              ),
            ),
          ),

          // Central Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo / Lottie
                Lottie.asset(
                  TImages.splashAppLogoAnimation,
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                // App Name with Premium Typography
                Text(
                  "Tamilnadu Matrimony",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontFamily: 'Urbanist',
                  ),
                ),

                const SizedBox(height: 8),

                // Tagline
                Text(
                  "Trusted by Millions to Find Their Perfect Match",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Urbanist',
                  ),
                ),
              ],
            ),
          ),

          // Bottom Loading / Branding
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "From the House of T-Matrimony",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
