import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/form_widgets/custom_text_form_widget.dart';
import '../../../../../utils/constants/path_provider.dart';
import '../../../controller/register/register_controller.dart';

class StepBasicDetails extends StatelessWidget {
  const StepBasicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    final primary = TColors.primary;

    return Scaffold(
      appBar: TAppBar(title: TTexts.basicDetails.tr),
      body: Form(
        key: controller.basicFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TFormField(
                label: TTexts.name.tr,
                controller: controller.nameController,
                hintText: "${TTexts.name.tr}...",
                icon: IconlyLight.profile,
                validator: (v) =>
                v == null || v.isEmpty ? "Please enter name" : null,
              ),
              TFormField(
                label: TTexts.gender.tr,
                isDropdown: true,
                icon: IconlyLight.user_1,
                items: ["Male", "Female", "Others"],
                onChanged: (val) => controller.gender.value = val ?? '',
                validator: (v) =>
                (v == null || v.isEmpty) ? "Please select gender" : null,
              ),
              TFormField(
                label: TTexts.dob.tr,
                hintText: "DD-MM-YYYY",
                icon: IconlyLight.calendar,
                controller: TextEditingController(),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Enter date of birth" : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: TFormField(
                      label: TTexts.height.tr,
                      controller: controller.heightController,
                      hintText: "in cm",
                      icon: Icons.height,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TFormField(
                      label: TTexts.weight.tr,
                      controller: controller.weightController,
                      hintText: "in kg",
                      icon: Icons.monitor_weight_outlined,
                    ),
                  ),
                ],
              ),
              TFormField(
                label: TTexts.maritalStatus.tr,
                isDropdown: true,
                icon: IconlyLight.heart,
                items: ["Single", "Divorced", "Widowed"],
                onChanged: (v) => controller.maritalStatus.value = v ?? '',
              ),
              TFormField(
                label: TTexts.education.tr,
                controller: controller.educationController,
                icon: Icons.school_outlined,
              ),
              TFormField(
                label: TTexts.occupation.tr,
                controller: controller.occupationController,
                icon: IconlyLight.bag_2,
              ),
              TFormField(
                label: TTexts.income.tr,
                controller: controller.incomeController,
                icon: IconlyLight.wallet,
              ),
              TFormField(
                label: TTexts.religion.tr,
                isDropdown: true,
                icon: Icons.temple_hindu_outlined,
                items: ["Hindu", "Muslim", "Christian", "Others"],
                onChanged: (v) => controller.religion.value = v ?? '',
              ),
              TFormField(
                label: TTexts.caste.tr,
                isDropdown: true,
                icon: IconlyLight.user,
                items: ["Brahmin", "Naidu", "Gounder", "Others"],
                onChanged: (v) => controller.caste.value = v ?? '',
              ),
              TFormField(
                label: TTexts.subCaste.tr,
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
                onPressed: controller.nextStep,
                child: Text(
                  TTexts.tContinue.tr,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
