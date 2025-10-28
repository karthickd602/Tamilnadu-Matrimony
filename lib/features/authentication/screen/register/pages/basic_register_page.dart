import 'package:iconly/iconly.dart';
import 'package:tamilnadu_matrimony/features/authentication/model/dropdown_model.dart';
import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../../common/widgets/dropdown/dropdown_with_search.dart';
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
              validator: (v) => TValidator.validateEmptyText(TTexts.name.tr,v.toString()),
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
                  validator: (v) =>
                      TValidator.validateEmptyText(TTexts.dob.tr, v.toString()),
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
            TSearchDropdownField<EducationDDModel>(
              label: TTexts.highEducation.tr, items: controller.educationDDList,
              prefixIcon: Icons.school_outlined,
              selectedItem: controller.selectedEducation.value,
              itemAsString: (item) => item.name.toString(),
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                if (value == null) return;
                controller.selectedEducation.value = value;
              },
              validator: (value) => TValidator.validateEmptyText(
                TTexts.occupationDetails.tr,
                value?.name,
              ),

            ),
            TFormField(
              labelText: TTexts.educationDetails.tr,
              controller: controller.educationDetailsController,
              icon: Icons.school_outlined,
            ),
            TSearchDropdownField<OccupationDDModel>(
              label: TTexts.occupationDetails.tr, items: controller.occupationDDList,
              prefixIcon: Icons.school_outlined,
              selectedItem: controller.selectedOccupation.value,
              itemAsString: (item) => item.name.toString(),
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                if (value == null) return;
                controller.selectedOccupation.value = value;
              },
              validator: (value) => TValidator.validateEmptyText(
                TTexts.occupationDetails.tr,
                value?.name,
              ),

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
            TSearchDropdownField<ReligionDDModel>(
              prefixIcon: Icons.temple_hindu_outlined,
              label: TTexts.religion.tr, items: controller.religionDDList,
              selectedItem: controller.selectedReligion.value,
              itemAsString: (item) => item.name.toString(),
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                if (value == null) return;
                controller.selectedReligion.value = value;
                controller.fetchCasteDropdown(religionId: value.id);
              },
              validator: (value) => TValidator.validateEmptyText(
                TTexts.religion.tr,
                value?.name,
              ),
            ),
            Obx(()=>controller.selectedReligion.value==null?SizedBox(): SizedBox(height: TSizes.sm,)),
            Obx(
              ()=>controller.selectedReligion.value==null?SizedBox() : TSearchDropdownField<CasteDDModel>(
                prefixIcon:  IconlyLight.user,
                label: TTexts.caste.tr, items: controller.casteDDList,
                selectedItem: controller.selectedCaste.value,
                itemAsString: (item) => item.name.toString(),
                compareFn: (a, b) => a.name == b.name,
                onChanged: (value) {
                  if (value == null) return;
                  controller.selectedCaste.value = value;
                },
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.caste.tr,
                  value?.name,
                ),

              ),
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
