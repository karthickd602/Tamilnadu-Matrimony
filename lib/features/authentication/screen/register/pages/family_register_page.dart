import 'package:iconly/iconly.dart';
import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

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
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TFormField(
                labelText: TTexts.fatherName.tr,
                controller: controller.fatherNameController,
                icon: Iconsax.user,
                validator:(v)=> TValidator.validateEmptyText(TTexts.fatherName.tr, v.toString()),
              ),
              TFormField(
                labelText: TTexts.fatherOccupation.tr,
                controller: controller.fatherOccupationController,
                icon: Iconsax.briefcase,
              ),
              TFormField(
                labelText: TTexts.motherName.tr,
                controller: controller.motherNameController,
                icon: IconlyLight.user,
              ),
              TFormField(
                labelText: TTexts.motherOccupation.tr,
                controller: controller.motherOccupationController,
                icon: Iconsax.briefcase,
              ),
              TFormField(
                labelText: TTexts.familyStatus.tr,
                isDropdown: true,
                icon: IconlyLight.home,
                items: ["Middle Class", "Upper Middle", "Rich", "Affluent"],
                onChanged: (v) {
                  controller.familyStatusController.value = v?? '';
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: TFormField(
                      labelText: TTexts.brothers.tr,
                      controller: controller.brothersController,
                      hintText: "0",
                      icon: Icons.male_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TFormField(
                      labelText: TTexts.sisters.tr,
                      controller: controller.sistersController,
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
                      controller: controller.marriedBrothersController,
                      hintText: "0",
                      keyboardType: TextInputType.number,
                      icon: Icons.male_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TFormField(
                      labelText: TTexts.marriedSisters.tr,
                      controller: controller.marriedSistersController,
                      keyboardType: TextInputType.number,
                      hintText: "0",
                      icon: Icons.female_outlined,
                    ),
                  ),
                ],
              ),
              TFormField(
                labelText: TTexts.nativePlace.tr,
                controller: controller.nativePlaceController,
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
