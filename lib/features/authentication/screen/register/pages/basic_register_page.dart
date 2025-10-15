import 'package:iconly/iconly.dart';
import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';

class StepBasicDetails extends StatelessWidget {
  const StepBasicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    final primary = TColors.primary;

    return Form(
      key: controller.basicFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TFormField(
              labelText: TTexts.name.tr,
              controller: controller.nameController,
              icon: IconlyLight.profile,
              validator: (v) => TValidator.validateEmptyText(TTexts.name.tr, v),
            ),
            TFormField(
              labelText: TTexts.gender.tr,
              isDropdown: true,
              icon: IconlyLight.user_1,
              hintText: TTexts.gender.tr,
              items: ["Male", "Female"],
              onChanged: (val) => controller.gender.value = val ?? '',
              validator: (v) =>
                  TValidator.validateEmptyText(TTexts.gender.tr, v),
            ),
            GestureDetector(
              onTap: ()=>THelperFunctions.showDatePickerField(controller.dobController,initialDate: DateTime(2000)),
              child: AbsorbPointer(
                child: TFormField(
                  isReadOnly: true,
                  labelText: TTexts.dob.tr,
                  hintText: "DD-MM-YYYY",
                  icon: IconlyLight.calendar,
                  controller:controller.dobController,
                  validator: (v) => TValidator.validateEmptyText(TTexts.dob.tr, v),
                ),
              ),
            ),

            TFormField(
              labelText: TTexts.height.tr,
              controller: controller.heightController,
              hintText: "in cm",
              icon: Icons.height,
            ),
            TFormField(
              labelText: TTexts.maritalStatus.tr,
              isDropdown: true,
              icon: IconlyLight.heart,
              items: ["Single", "Divorced", "Widowed"],
              onChanged: (v) => controller.maritalStatus.value = v ?? '',
            ),
            TFormField(
              labelText: TTexts.education.tr,
              controller: controller.educationController,
              icon: Icons.school_outlined,
            ),
            TFormField(
              labelText: TTexts.occupation.tr,
              controller: controller.occupationController,
              icon: IconlyLight.bag_2,
            ),
            TFormField(
              labelText: TTexts.income.tr,
              controller: controller.incomeController,
              icon: IconlyLight.wallet,
            ),
            TFormField(
              labelText: TTexts.religion.tr,
              isDropdown: true,
              icon: Icons.temple_hindu_outlined,
              items: ["Hindu", "Muslim", "Christian", "Others"],
              onChanged: (v) => controller.religion.value = v ?? '',
            ),
            TFormField(
              labelText: TTexts.caste.tr,
              isDropdown: true,
              icon: IconlyLight.user,
              items: ["Brahmin", "Naidu", "Gounder", "Others"],
              onChanged: (v) => controller.caste.value = v ?? '',
            ),
            TFormField(
              labelText: TTexts.subCaste.tr,
              controller: controller.subCasteController,
              icon: IconlyLight.user,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => controller.basicFormSubmit(),
              child: Text(
                TTexts.tContinue.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
