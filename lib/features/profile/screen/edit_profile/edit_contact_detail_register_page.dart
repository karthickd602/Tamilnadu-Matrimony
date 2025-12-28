import 'package:tamilnadu_matrimony/features/profile/controller/edit_profile_controller/edit_profile_controller.dart';

import '../../../../common/widgets/dropdown/dropdown_with_search.dart';
import '../../../../utils/constants/path_provider.dart';
import '../../../../utils/validators/validation.dart';
import '../../../authentication/model/dropdown_model.dart';

class EditContactDetails extends StatelessWidget {
  const EditContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProfileController.instance;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = TColors.primary;
    // final secondaryColor = Colors.grey[100];

    return Form(
      key: controller.contactFormKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Alternate Mobile ---
            TFormField(
              controller: controller.alternateMobileController,
              labelText: TTexts.alternateMobile.tr,
              icon: Icons.phone,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              validator: (value) => TValidator.validateEmptyText(
                TTexts.mobileNo.tr,
                value.toString(),
              ),
            ),

            /// --- Email ---
            TFormField(
              controller: controller.emailController,
              labelText: TTexts.email.tr,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              // validator: (value) => TValidator.validateEmptyText(
              //   TTexts.email.tr,
              //   value.toString(),
              // ),
            ),

            /// --- Address ---
            TFormField(
              controller: controller.addressController,
              labelText: TTexts.address.tr,
              icon: Icons.home_outlined,
              keyboardType: TextInputType.streetAddress,
              validator: (value) => TValidator.validateEmptyText(
                TTexts.address.tr,
                value.toString(),
              ),
            ),

            TSearchDropdownField<CountryModel>(
              label: TTexts.country.tr,
              items: controller.countryList,
              prefixIcon: Icons.map,
              selectedItem: controller.selectedCountry.value,
              itemAsString: (item) => item.name.toString(),
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                if (value == null) return;
                controller.selectedCountry.value = value;
                controller.fetchStateDropdown();
              },
              validator: (value) =>
                  TValidator.validateEmptyText(TTexts.country.tr, value?.name),
            ),

            SizedBox(height: TSizes.sm),
            TSearchDropdownField<CountryModel>(
              label: TTexts.state.tr,
              items: controller.stateList,
              prefixIcon: Icons.school_outlined,
              selectedItem: controller.selectedState.value,
              itemAsString: (item) => item.name.toString(),
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                if (value == null) return;
                controller.selectedState.value = value;
                controller.selectedDistrict.value = null;
                controller.fetchDistrictDropdown();
              },
              validator: (value) =>
                  TValidator.validateEmptyText(TTexts.state.tr, value?.name),
            ),
            SizedBox(height: TSizes.sm),
            TSearchDropdownField<CountryModel>(
              label: TTexts.district.tr,
              items: controller.districtList,
              prefixIcon: Icons.map_outlined,
              selectedItem: controller.selectedDistrict.value,
              itemAsString: (item) => item.name.toString(),
              compareFn: (a, b) => a.name == b.name,
              onChanged: (value) {
                if (value == null) return;

                controller.selectedDistrict.value = value;
                // controller.fetchDistrictDropdown();
              },
              validator: (value) =>
                  TValidator.validateEmptyText(TTexts.district.tr, value?.name),
            ),

            /// --- Pincode ---
            TFormField(
              controller: controller.pincodeController,
              labelText: TTexts.pincode.tr,
              icon: Icons.local_post_office_outlined,
              maxLength: 6,
              validator: (value) => TValidator.validateEmptyText(
                TTexts.pincode.tr,
                value.toString(),
              ),
              keyboardType: TextInputType.number,
            ),

            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: controller.noCasteChecked.value,
                    onChanged: (newValue) {
                      controller.noCasteChecked.value = newValue!;
                    },
                  ),
                  const SizedBox(width: TSizes.xs),
                  Text(
                    TTexts.noCaste.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// --- Submit Button ---
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
                    onPressed: () => controller.contactFormSubmit(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      // padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // icon: const Icon(Icons.check_circle_outline),
                    child: Text(TTexts.submit.tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
