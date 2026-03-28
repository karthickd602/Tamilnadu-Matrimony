import 'package:iconly/iconly.dart';
import 'package:tamilnadu_matrimony/features/authentication/model/dropdown_model.dart';
import 'package:tamilnadu_matrimony/utils/validators/validation.dart';

import '../../../../../common/widgets/dropdown/dropdown_with_search.dart';
import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';
import '../../../dropdown_list.dart';

class StepBasicDetails extends StatelessWidget {
  const StepBasicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    final primary = TColors.primary;

    return Form(
      key: controller.basicFormKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => Column(
              children: [
                TFormField(
                  labelText: TTexts.name.tr,
                  controller: controller.nameController,
                  icon: IconlyLight.profile,
                  validator: (v) => TValidator.validateEmptyText(
                    TTexts.name.tr,
                    v.toString(),
                  ),
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
                    value?.label,
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
                    TTexts.unMarried.tr,
                    TTexts.widowed.tr,
                    TTexts.divorced.tr,
                    TTexts.separated.tr,
                  ],
                  prefixIcon: Icons.join_inner_outlined,
                  selectedItem: controller.maritalStatus.value,
                  itemAsString: (item) => item.toString(),
                  compareFn: (a, b) => a == b,
                  onChanged: (value) {
                    if (value == null) return;
                    controller.maritalStatus.value = value ?? '';
                    controller.selectedNoOfChildren.value = null;
                    controller.childLivingStatus.value = '';
                  },
                  validator: (value) => TValidator.validateEmptyText(
                    TTexts.maritalStatus.tr,
                    value,
                  ),
                ),
                Obx(
                  () =>
                      (controller.maritalStatus.value == TTexts.unMarried.tr ||
                          controller.maritalStatus.value == '')
                      ? SizedBox()
                      : SizedBox(height: TSizes.sm),
                ),
                Obx(
                  () =>
                      (controller.maritalStatus.value == TTexts.unMarried.tr ||
                          controller.maritalStatus.value == '')
                      ? SizedBox()
                      : TSearchDropdownField<ChildCountModel>(
                          label: TTexts.noOfChildren.tr,
                          showSearchBox: false,
                          items: controller.childCountList,
                          prefixIcon: Icons.child_care,
                          selectedItem: controller.selectedNoOfChildren.value,
                          itemAsString: (item) => item.label.toString(),
                          compareFn: (a, b) => a.label == b.label,
                          onChanged: (value) {
                            if (value == null) return;
                            controller.selectedNoOfChildren.value = value;

                            controller.childLivingStatus.value = '';
                          },
                          validator: (value) => TValidator.validateEmptyText(
                            TTexts.noOfChildren.tr,
                            value?.label,
                          ),
                        ),
                ),
                SizedBox(height: TSizes.sm),
                Obx(
                  () =>
                      (controller.maritalStatus.value == TTexts.unMarried.tr ||
                          controller.selectedNoOfChildren.value?.id == "0" ||
                          controller.selectedNoOfChildren.value?.id == '' ||
                          controller.maritalStatus.value == '')
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
                      (controller.maritalStatus.value == TTexts.unMarried.tr ||
                          controller.selectedNoOfChildren.value?.id == "0" ||
                          controller.selectedNoOfChildren.value == null)
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
                    controller.occupationDetailsController.text = '';
                    controller.incomeController.text = '';
                  },
                  validator: (value) => TValidator.validateEmptyText(
                    TTexts.occupation.tr,
                    value?.name,
                  ),
                ),

                if (controller.selectedOccupation.value?.name
                        .toString()
                        .toLowerCase() !=
                    'not working')
                  TFormField(
                    labelText: TTexts.occupationDetails.tr,
                    controller: controller.occupationDetailsController,
                    icon: IconlyLight.bag_2,
                  ),
                if (controller.selectedOccupation.value?.name
                        .toString()
                        .toLowerCase() !=
                    'not working')
                  TFormField(
                    labelText: TTexts.income.tr,
                    keyboardType: TextInputType.number,
                    controller: controller.incomeController,
                    icon: IconlyLight.wallet,
                  ),
                if (controller.selectedOccupation.value?.name
                        .toString()
                        .toLowerCase() ==
                    'not working')
                  SizedBox(height: TSizes.sm),
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
                // Obx(
                //   () =>
                // (controller.selectedReligion.value == null ||
                //     controller.selectedReligion.value?.id != 1)
                // ? SizedBox()
                // :
                TSearchDropdownField<CasteDDModel>(
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
                // ),
                // Obx(
                //   () =>
                // (controller.selectedReligion.value == null ||
                //     controller.selectedReligion.value?.id != 1)
                // ? SizedBox()
                // :
                TFormField(
                  labelText: TTexts.subCaste.tr,
                  controller: controller.subCasteController,
                  icon: IconlyLight.user,
                ),
                // ),
                SizedBox(height: TSizes.sm),
                TSearchDropdownField<String>(
                  label: TTexts.disablePerson.tr,
                  showSearchBox: false,
                  items: [TTexts.yes.tr, TTexts.no.tr],
                  prefixIcon: Icons.check_box_outlined,
                  selectedItem: controller.isDisablePerson.value,
                  itemAsString: (item) => item.toString(),
                  compareFn: (a, b) => a == b,
                  onChanged: (value) {
                    if (value == null) return;
                    controller.isDisablePerson.value = value;
                  },
                  validator: (value) => TValidator.validateEmptyText(
                    TTexts.disablePerson.tr,
                    value,
                  ),
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
      ),
    );
  }
}
