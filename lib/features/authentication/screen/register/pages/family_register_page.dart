import 'package:iconly/iconly.dart';

import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';

class FamilyDetails extends StatelessWidget {
  const FamilyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistrationController.instance;
    final primary = TColors.primary;

    return Scaffold(
      // appBar: TAppBar(title: TTexts.familyDetails.tr),
      body: Form(
        key: controller.familyFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TFormField(
                labelText: TTexts.fatherName.tr,
                controller: TextEditingController(),
                icon: Iconsax.user,
              ),
              TFormField(
                labelText: TTexts.fatherOccupation.tr,
                controller: TextEditingController(),
                icon: Iconsax.briefcase,
              ),
              TFormField(
                labelText: TTexts.motherName.tr,
                controller: TextEditingController(),
                icon: IconlyLight.user,
              ),
              TFormField(
                labelText: TTexts.motherOccupation.tr,
                controller: TextEditingController(),
                icon: Iconsax.briefcase,
              ),
              TFormField(
                labelText: TTexts.familyStatus.tr,
                isDropdown: true,
                icon: IconlyLight.home,
                items: ["Middle Class", "Upper Middle", "Rich", "Affluent"],
                onChanged: (v) {},
              ),

              Row(
                children: [
                  Expanded(
                    child: TFormField(
                      labelText: TTexts.brothers.tr,
                      controller: TextEditingController(),
                      hintText: "0",
                      icon: Icons.male_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TFormField(
                      labelText: TTexts.sisters.tr,
                      controller: TextEditingController(),
                      hintText: "0",
                      icon: Icons.female_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ), Row(
                children: [
                  Expanded(
                    child: TFormField(
                      labelText: TTexts.marriedBrothers.tr,
                      controller: TextEditingController(),
                      hintText: "0",
                      keyboardType: TextInputType.number,
                      icon: Icons.male_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TFormField(
                      labelText: TTexts.marriedSisters.tr,
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                      hintText: "0",
                      icon: Icons.female_outlined,
                    ),
                  ),
                ],
              ),
              TFormField(
                labelText: TTexts.nativePlace.tr,
                controller: TextEditingController(),
                icon: IconlyLight.location,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.previousStep,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(TTexts.back.tr),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed:()=> controller.familyFormSubmit(),
                      child: Text(
                        TTexts.tContinue.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
