import 'dart:io';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';

class HoroscopeDetails extends StatelessWidget {
  const HoroscopeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RegistrationController.instance;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = TColors.primary;
    final secondaryColor = Colors.grey[100];

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: const TAppBar(title: "horoscope_details_title"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("horoscope_details".tr, style: textTheme.titleLarge),
            const SizedBox(height: 16),

            // Rasi
            TFormField(
              controller: controller.rasiController,
              label: "rasi".tr,
              icon: Icons.auto_awesome,
            ),
            const SizedBox(height: 12),

            // Nakshatra
            TFormField(
              controller: controller.nakshatraController,
              label: "nakshatra".tr,
              icon: Icons.star_outline,
            ),
            const SizedBox(height: 12),

            // Gothram
            TFormField(
              controller: controller.gothramController,
              label: "gothram".tr,
              icon: Icons.family_restroom_outlined,
            ),
            const SizedBox(height: 12),

            // Dosham Dropdown
            DropdownButtonFormField<String>(
              value: controller.dosham.value.isEmpty ? null : controller.dosham.value,
              items: ["yes".tr, "no".tr]
                  .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                  .toList(),
              onChanged: (value) {
                if (value != null) controller.dosham.value = value;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.warning_amber_rounded),
                labelText: "dosham".tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Upload Horoscope
            Text("upload_horoscope_image".tr, style: textTheme.titleMedium),
            const SizedBox(height: 8),

            Obx(() => GestureDetector(
              onTap: () => controller.pickHoroscopeImage(),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: controller.horoscopeImagePath.value.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, size: 40, color: primaryColor),
                    const SizedBox(height: 8),
                    Text("tap_to_upload".tr, style: textTheme.bodyMedium),
                  ],
                )
                    : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(controller.horoscopeImagePath.value),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () =>
                          controller.horoscopeImagePath.value = '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),

            const SizedBox(height: 24),

            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => controller.nextStep(),
                icon: const Icon(Icons.arrow_forward_ios),
                label: Text("continue".tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
