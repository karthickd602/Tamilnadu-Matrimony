import '../../utils/constants/path_provider.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: TColors.yellow,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Center(
          child: Image.asset(
            TImages.splashScreen,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            // repeat: true, // set false if you want play once
          ),
        ),
      ),
    );
  }
}
