import 'package:iconly/iconly.dart';
import 'package:tamilnadu_matrimony/features/authentication/model/dropdown_model.dart';
import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../../common/widgets/dropdown/dropdown_with_search.dart';
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
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            children: [
              TFormField(
                labelText: TTexts.name.tr,
                controller: controller.nameController,
                icon: IconlyLight.profile,
                validator: (v) =>
                    TValidator.validateEmptyText(TTexts.name.tr, v.toString()),
              ),

              TSearchDropdownField<String>(
                label: TTexts.gender.tr,
                showSearchBox: false,
                items: controller.genderList,
                prefixIcon: Icons.person,
                selectedItem: controller.selectedGender.value,
                itemAsString: (item) => item.toString(),
                compareFn: (a, b) => a == b,
                onChanged: (value) {
                  if (value == null) return;
                  controller.selectedGender.value = value;
                },
                validator: (value) =>
                    TValidator.validateEmptyText(TTexts.gender.tr, value),
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
                    validator: (v) => TValidator.validateEmptyText(
                      TTexts.dob.tr,
                      v.toString(),
                    ),
                  ),
                ),
              ),

              // TFormField(
              //   labelText: TTexts.height.tr,
              //   controller: controller.heightController,
              //   hintText: "in cm",
              //   icon: Icons.height,
              // ),
              TSearchDropdownField<HeightOption>(
                label: TTexts.height.tr,
                showSearchBox: false,
                items: controller.heightList,
                prefixIcon: Icons.color_lens_outlined,
                selectedItem: controller.selectedHeight.value,
                itemAsString: (item) => item.label.toString(),
                compareFn: (a, b) => a.label == b.label,
                onChanged: (value) {
                  if (value == null) return;
                  controller.selectedHeight.value = value;
                },
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.height.tr,
                  value.toString(),
                ),
              ),
              SizedBox(height: TSizes.sm),
              TSearchDropdownField<String>(
                label: TTexts.complexion.tr,
                showSearchBox: false,
                items: ["சிவப்பு", "மாநிறம்", "புது நிறம்", "கருப்பு"],
                prefixIcon: Icons.color_lens_outlined,
                selectedItem: controller.selectedComplexion.value,
                itemAsString: (item) => item.toString(),
                compareFn: (a, b) => a == b,
                onChanged: (value) {
                  if (value == null) return;
                  controller.selectedComplexion.value = value;
                },
                validator: (value) =>
                    TValidator.validateEmptyText(TTexts.complexion.tr, value),
              ),
              SizedBox(height: TSizes.sm),

              TSearchDropdownField<String>(
                label: TTexts.maritalStatus.tr,
                showSearchBox: false,
                items: [
                  "திருமணம் ஆகாதவர்",
                  " துணையை இழந்தவர்",
                  "விவாகரத்து ஆனவர்",
                  "பிரிந்து வாழ்பவர்",
                ],
                prefixIcon: Icons.join_inner_outlined,
                selectedItem: controller.maritalStatus.value,
                itemAsString: (item) => item.toString(),
                compareFn: (a, b) => a == b,
                onChanged: (value) {
                  if (value == null) return;
                  controller.maritalStatus.value = value ?? '';
                  controller.noOfChildren.value = '';
                  controller.childLivingStatus.value = '';
                },
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.maritalStatus.tr,
                  value,
                ),
              ),
              Obx(
                () =>
                    (controller.maritalStatus.value == "திருமணம் ஆகாதவர்" ||
                        controller.maritalStatus.value == '')
                    ? SizedBox()
                    : SizedBox(height: TSizes.sm),
              ),
              Obx(
                () =>
                    (controller.maritalStatus.value == "திருமணம் ஆகாதவர்" ||
                        controller.maritalStatus.value == '')
                    ? SizedBox()
                    : TSearchDropdownField<String>(
                        label: TTexts.noOfChildren.tr,
                        showSearchBox: false,
                        items: ["0", "1", "2", "3", "4"],
                        prefixIcon: Icons.child_care,
                        selectedItem: controller.noOfChildren.value,
                        itemAsString: (item) => item.toString(),
                        compareFn: (a, b) => a == b,
                        onChanged: (value) {
                          if (value == null) return;

                          controller.noOfChildren.value = value ?? '';

                          controller.childLivingStatus.value = '';
                        },
                        validator: (value) => TValidator.validateEmptyText(
                          TTexts.noOfChildren.tr,
                          value,
                        ),
                      ),
              ),
              SizedBox(height: TSizes.sm),
              Obx(
                () =>
                    (controller.maritalStatus.value == "திருமணம் ஆகாதவர்" ||
                        controller.noOfChildren.value == "0" ||
                        controller.noOfChildren.value == '')
                    ? SizedBox()
                    : TSearchDropdownField<String>(
                        label: TTexts.childrenLivingStatus.tr,
                        showSearchBox: false,
                        items: ["Living with me", "Not living with me"],
                        prefixIcon: Icons.baby_changing_station_outlined,
                        selectedItem: controller.childLivingStatus.value,
                        itemAsString: (item) => item.toString(),
                        compareFn: (a, b) => a == b,
                        onChanged: (value) {
                          if (value == null) return;
                          controller.childLivingStatus.value = value ?? '';
                        },
                        validator: (value) => TValidator.validateEmptyText(
                          TTexts.childrenLivingStatus.tr,
                          value,
                        ),
                      ),
              ),
              Obx(
                () =>
                    (controller.maritalStatus.value == "திருமணம் ஆகாதவர்" ||
                        controller.noOfChildren.value == "0" ||
                        controller.noOfChildren.value == '')
                    ? SizedBox()
                    : SizedBox(height: TSizes.sm),
              ),

              TSearchDropdownField<EducationDDModel>(
                label: TTexts.highEducation.tr,
                items: controller.educationDDList,
                prefixIcon: Icons.school_outlined,
                selectedItem: controller.selectedEducation.value,
                itemAsString: (item) => item.name.toString(),
                compareFn: (a, b) => a.name == b.name,
                onChanged: (value) {
                  if (value == null) return;
                  controller.selectedEducation.value = value;
                },
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.highEducation.tr,
                  value?.name,
                ),
              ),
              TFormField(
                labelText: TTexts.educationDetails.tr,
                controller: controller.educationDetailsController,
                icon: Icons.school_outlined,
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.educationDetails.tr,
                  value.toString(),
                ),
              ),
              TSearchDropdownField<OccupationDDModel>(
                label: TTexts.occupation.tr,
                items: controller.occupationDDList,
                prefixIcon: Icons.school_outlined,
                selectedItem: controller.selectedOccupation.value,
                itemAsString: (item) => item.name.toString(),
                compareFn: (a, b) => a.name == b.name,
                onChanged: (value) {
                  if (value == null) return;
                  controller.selectedOccupation.value = value;
                },
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.occupation.tr,
                  value?.name,
                ),
              ),

              TFormField(
                labelText: TTexts.occupationDetails.tr,
                controller: controller.occupationDetailsController,
                icon: IconlyLight.bag_2,
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.occupationDetails,
                  value.toString(),
                ),
              ),
              TFormField(
                labelText: TTexts.income.tr,
                keyboardType: TextInputType.number,
                controller: controller.incomeController,
                icon: IconlyLight.wallet,
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.income.tr,
                  value.toString(),
                ),
              ),
              TSearchDropdownField<ReligionDDModel>(
                prefixIcon: Icons.temple_hindu_outlined,
                label: TTexts.religion.tr,
                items: controller.religionDDList,
                selectedItem: controller.selectedReligion.value,
                itemAsString: (item) => item.name.toString(),
                compareFn: (a, b) => a.name == b.name,
                onChanged: (value) {
                  if (value == null) return;
                  controller.selectedReligion.value = value;
                  controller.selectedCaste.value = null;
                  controller.fetchCasteDropdown(religionId: value.id);
                },
                validator: (value) => TValidator.validateEmptyText(
                  TTexts.religion.tr,
                  value?.name,
                ),
              ),
              Obx(
                () => controller.selectedReligion.value == null
                    ? SizedBox()
                    : SizedBox(height: TSizes.sm),
              ),
              Obx(
                () =>
                    (controller.selectedReligion.value == null ||
                        controller.selectedReligion.value?.id != 1)
                    ? SizedBox()
                    : TSearchDropdownField<CasteDDModel>(
                        prefixIcon: IconlyLight.user,
                        label: TTexts.caste.tr,
                        items: controller.casteDDList,
                        selectedItem: controller.selectedCaste.value,
                        itemAsString: (item) => item.name.toString(),
                        compareFn: (a, b) => a.name == b.name,
                        onChanged: (value) {
                          if (value == null) return;
                          controller.selectedCaste.value = value;
                          controller.subCasteController.text = '';
                        },
                        validator: (value) => TValidator.validateEmptyText(
                          TTexts.caste.tr,
                          value?.name,
                        ),
                      ),
              ),

              Obx(
                () =>
                    (controller.selectedReligion.value == null ||
                        controller.selectedReligion.value?.id != 1)
                    ? SizedBox()
                    : TFormField(
                        labelText: TTexts.subCaste.tr,
                        controller: controller.subCasteController,
                        icon: IconlyLight.user,
                      ),
              ),
              TFormField(
                labelText: TTexts.disablePerson.tr,
                isDropdown: true,
                icon: Icons.check_box_outlined,
                items: ["Yes", "No"],
                value: controller.isDisablePerson.value,
                onChanged: (v) => controller.isDisablePerson.value = v ?? '',
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.basicFormSubmit(),
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: TColors.primary)
                      : Text(
                          TTexts.tContinue.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
