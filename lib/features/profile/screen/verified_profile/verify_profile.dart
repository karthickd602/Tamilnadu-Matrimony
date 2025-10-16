import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/features/authentication/screen/register/widgets/get_image.dart';
import 'package:tamilnadu_matrimony/features/profile/controller/verify_profile_controller.dart';

import '../../../../utils/constants/path_provider.dart';

class VerifyProfile extends StatelessWidget {
  const VerifyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyProfileController());
    return Scaffold(
      appBar: TAppBar(
        title: "Verify Profile with govt ID",
        isBackButtonNeed: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ImagePickerBox(
                title: "Upload your PAN or Aadhaar card",
                imagePath: controller.documentPath,
                onPickImage:()=> controller.showImageSourceSheet(
                  imagePath: controller.documentPath,
                ),
              ),

              SizedBox(height: TSizes.spaceBtwSections,),
              SizedBox(width:140,child: ElevatedButton(onPressed: (){}, child: Text("Submit")))
            ],
          ),
        ),
      ),
    );
  }
}
