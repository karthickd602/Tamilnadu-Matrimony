import 'package:tamilnadu_matrimony/features/authentication/model/dropdown_model.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../../../../../common/widgets/dropdown/dropdown_with_search.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/register/register_controller.dart';
import '../widgets/get_image.dart';

class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistrationController.instance;
    final primaryColor = TColors.primary;

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
              keyboardType: TextInputType.phone,
            ),

            /// --- Email ---
            TFormField(
              controller: controller.emailController,
              labelText: TTexts.email.tr,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            /// --- Address ---
            TFormField(
              controller: controller.addressController,
              labelText: TTexts.address.tr,
              icon: Icons.home_outlined,
              keyboardType: TextInputType.streetAddress,
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
              validator: (value) => TValidator.validateEmptyText(
                TTexts.country.tr,
                value?.name,
              ),
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
                controller.selectedDistrict.value=null;
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
              keyboardType: TextInputType.number,
            ),

            ImagePickerBox(
              title: TTexts.profile.tr,
              onPickImage: () => controller.selectHoroscopeImage(context),
              imagePath: controller.profileImagePath,
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
