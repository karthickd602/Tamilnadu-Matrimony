import 'package:iconly/iconly.dart';
import 'package:tamilnadu_matrimony/utils/validators/validation.dart';
import '../../../../../utils/constants/path_provider.dart';
import '../../controller/edit_profile_controller/edit_profile_controller.dart';

class EditBasicDetails extends StatelessWidget {
  const EditBasicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    final primary = TColors.primary;

    return Form(
      key: controller.basicFormKey,
      child: SingleChildScrollView(
        padding:  EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TFormField(
              labelText: TTexts.name.tr,
              controller: controller.nameController,
              icon: IconlyLight.profile,
              // validator: (v) => TValidator.validateEmptyText(TTexts.name.tr, v),
            ),
            TFormField(
              labelText: TTexts.gender.tr,
              isDropdown: true,
              icon: IconlyLight.user_1,
              hintText: TTexts.gender.tr,
              items: [TTexts.male.tr, TTexts.female.tr],
              onChanged: (val) => controller.gender.value = val ?? '',
              validator: (v) =>
                  TValidator.validateEmptyText(TTexts.gender.tr, v),
            ),
            GestureDetector(
              onTap: () => THelperFunctions.showDatePickerField(
                controller.dobController,
                initialDate: DateTime(2000),
              ),
              child: AbsorbPointer(
                child: TFormField(
                  isReadOnly: true,
                  labelText: TTexts.dob.tr,
                  hintText: "DD-MM-YYYY",
                  icon: IconlyLight.calendar,
                  controller: controller.dobController,
                  // validator: (v) =>
                  //     TValidator.validateEmptyText(TTexts.dob.tr, v),
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
              labelText: TTexts.complexion.tr,
              isDropdown: true,
              icon: Icons.color_lens_outlined,
              items: ["சிவப்பு","மாநிறம்", "புது நிறம்", "கருப்பு"],
              onChanged: (v) => controller.colorComplexion.value = v ?? '',
            ),TFormField(
              labelText: TTexts.maritalStatus.tr,
              isDropdown: true,
              icon: Icons.join_inner_outlined,
              items: ["திருமணம் ஆகாதவர்", " துணையை இழந்தவர்", "விவாகரத்து ஆனவர்","பிரிந்து வாழ்பவர்"],
              onChanged: (v) => controller.maritalStatus.value = v ?? '',
            ),

            Obx(
              ()=>(controller.maritalStatus.value == "திருமணம் ஆகாதவர்"|| controller.maritalStatus.value =='')?SizedBox(): TFormField(
                labelText: TTexts.noOfChildren.tr,
                isDropdown: true,
                icon: Icons.baby_changing_station_outlined,
                items: ["0", "1", "2","3","4"],
                onChanged: (v) => controller.noOfChildren.value = v ?? '',
              ),
            ),

            Obx(
              ()=> (controller.noOfChildren.value == "0"|| controller.noOfChildren.value =='')?SizedBox():TFormField(
                labelText: TTexts.childrenLivingStatus.tr,
                isDropdown: true,
                icon: Icons.baby_changing_station_outlined,
                items: ["Living with me", "Not living with me"],
                onChanged: (v) => controller.maritalStatus.value = v ?? '',
              ),
            ),
            TFormField(
              isDropdown: true,
              items: ["BE","ME","B.Sc"],
              labelText: TTexts.highEducation.tr,
              onChanged: (v) => controller.eduction.value = v ?? '',
              icon: Icons.school_outlined,
            ),
            TFormField(
              labelText: TTexts.educationDetails.tr,
              controller: controller.educationDetailsController,
              icon: Icons.school_outlined,
            ),
            TFormField(
              isDropdown: true,
              items: ["IT","Accountant",'Business'],
              labelText: TTexts.occupationDetails.tr,
              onChanged: (v) => controller.occupation.value = v ?? '',
              icon: IconlyLight.bag_2,
            ),
            TFormField(
              labelText: TTexts.occupation.tr,
              controller: controller.occupationDetailsController,
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
            TFormField(
              labelText: TTexts.disablePerson.tr,
              isDropdown: true,
              icon: Icons.check_box_outlined,
              items: ["Yes", "No",],
              value: controller.isDisablePerson.value,
              onChanged: (v) => controller.isDisablePerson.value = v ?? '',
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
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
