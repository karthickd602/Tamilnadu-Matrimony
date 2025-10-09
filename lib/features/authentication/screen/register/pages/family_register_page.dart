import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';

class FamilyDetails extends StatelessWidget {
  const FamilyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistrationController.instance;
    final primary = TColors.primary;

    return Scaffold(
      appBar: TAppBar(title: TTexts.familyDetails.tr),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TFormField(
                label: TTexts.fatherName.tr,
                controller: TextEditingController(),
                hintText: "${TTexts.fatherName.tr}...",
                icon: Iconsax.user2,
              ),
              TFormField(
                label: TTexts.fatherOccupation.tr,
                controller: TextEditingController(),
                icon: Iconsax.briefcase,
              ),
              TFormField(
                label: TTexts.motherName.tr,
                controller: TextEditingController(),
                icon: IconlyLight.user,
              ),
              TFormField(
                label: TTexts.motherOccupation.tr,
                controller: TextEditingController(),
                icon: Iconsax.briefcase,
              ),
              TFormField(
                label: TTexts.familyStatus.tr,
                isDropdown: true,
                icon: IconlyLight.home,
                items: ["Middle Class", "Upper Middle", "Rich", "Affluent"],
                onChanged: (v) {},
              ),
              TFormField(
                label: TTexts.familyType.tr,
                isDropdown: true,
                icon: Icons.groups_2_outlined,
                items: ["Joint Family", "Nuclear Family"],
                onChanged: (v) {},
              ),
              Row(
                children: [
                  Expanded(
                    child: TFormField(
                      label: TTexts.brothers.tr,
                      controller: TextEditingController(),
                      hintText: "0",
                      icon: Icons.male_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TFormField(
                      label: TTexts.sisters.tr,
                      controller: TextEditingController(),
                      hintText: "0",
                      icon: Icons.female_outlined,
                    ),
                  ),
                ],
              ),
              TFormField(
                label: TTexts.nativePlace.tr,
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
                      onPressed: controller.nextStep,
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
