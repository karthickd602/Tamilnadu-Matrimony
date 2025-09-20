import 'package:lottie/lottie.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/path_provider.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: TColors.yellow,
      body: Container(
        width: double.infinity,
        padding:  EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            Center(
              child: Lottie.asset(
                'assets/logos/splash_animation.json',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
                repeat: true, // set false if you want play once
              ),
            ),
            SizedBox(height: TSizes.sm),
            Text("Tamilnadu Matrimony",style: Theme.of(context).textTheme.headlineLarge,),
            SizedBox(height: TSizes.sm),
            Text("தமிழ்நாடு மேட்ரிமோனி",style: Theme.of(context).textTheme.headlineLarge,)

          ],
        ),
      ),
    );
  }
}
