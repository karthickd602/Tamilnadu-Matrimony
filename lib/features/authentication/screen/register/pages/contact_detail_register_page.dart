import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/register/register_controller.dart';

class ContactDetailsStep extends StatelessWidget {
  ContactDetailsStep({super.key});
  final RegistrationController controller = Get.find();

  final states = ['Tamil Nadu', 'Karnataka', 'Kerala', 'Andhra', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Container(
      // key: controller.formKeys[3],
      // child: SingleChildScrollView(
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //   child: Column(
      //     children: [
      //       TextFormField(
      //         controller: controller.addressCtrl,
      //         decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
      //         maxLines: 2,
      //         validator: (v) => v == null || v.trim().isEmpty ? 'Please enter address' : null,
      //       ),
      //       const SizedBox(height: 12),
      //       DropdownButtonFormField<String>(
      //         value: controller.stateCtrl.value.isEmpty ? null : controller.stateCtrl.value,
      //         items: states.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
      //         onChanged: (v) => controller.stateCtrl.value = v ?? '',
      //         decoration: const InputDecoration(labelText: 'State', border: OutlineInputBorder()),
      //         validator: (v) => v == null || v.isEmpty ? 'Select state' : null,
      //       ),
      //       const SizedBox(height: 12),
      //       // TextFormField(
      //       //   controller: controller.cityCtrl = TextEditingController(text: controller.cityCtrl.value),
      //       //   onChanged: (v) => controller.cityCtrl.value = v,
      //       //   decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
      //       //   validator: (v) => v == null || v.trim().isEmpty ? 'Enter city' : null,
      //       // ),
      //       const SizedBox(height: 12),
      //       TextFormField(
      //         controller: controller.whatsappCtrl,
      //         decoration: const InputDecoration(labelText: 'Whatsapp / Contact', border: OutlineInputBorder()),
      //         keyboardType: TextInputType.phone,
      //       ),
      //       const SizedBox(height: 12),
      //       TextFormField(
      //         controller: controller.passwordCtrl,
      //         decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
      //         obscureText: true,
      //         validator: (v) => v == null || v.trim().length < 6 ? 'At least 6 chars' : null,
      //       ),
      //       const SizedBox(height: 12),
      //       TextFormField(
      //         controller: controller.expectationsCtrl,
      //         decoration: const InputDecoration(labelText: 'Expectations (optional)', border: OutlineInputBorder()),
      //         maxLines: 2,
      //       ),
      //       const SizedBox(height: 12),
      //
      //       // Profile photo
      //       Align(
      //         alignment: Alignment.centerLeft,
      //         child: Text('Upload profile photo', style: TextStyle(color: Colors.grey[700])),
      //       ),
      //       const SizedBox(height: 8),
      //       Obx(() {
      //         final photo = controller.profilePhoto.value;
      //         return Row(
      //           children: [
      //             GestureDetector(
      //               onTap: () => _showPickDialog(context),
      //               child: Container(
      //                 width: 100,
      //                 height: 100,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(8),
      //                   border: Border.all(color: Colors.grey),
      //                 ),
      //                 child: photo == null
      //                     ? const Icon(Icons.person, size: 40, color: Colors.grey)
      //                     : ClipRRect(
      //                   borderRadius: BorderRadius.circular(8),
      //                   child: Image.file(File(photo.path), fit: BoxFit.cover),
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(width: 12),
      //             Expanded(
      //               child: Text(photo == null ? 'Attach a clear headshot (recommended)' : 'Profile photo attached'),
      //             ),
      //           ],
      //         );
      //       }),
      //       const SizedBox(height: 16),
      //     ],
      //   ),
      // ),
    );
  }

  // void _showPickDialog(BuildContext context) {
  //   Get.bottomSheet(
  //     SafeArea(
  //       child: Wrap(
  //         children: [
  //           ListTile(
  //             leading: const Icon(Icons.photo_camera),
  //             title: const Text('Camera'),
  //             onTap: () {
  //               Get.back();
  //               controller.pickProfilePhotoCamera();
  //             },
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.photo_library),
  //             title: const Text('Gallery'),
  //             onTap: () {
  //               Get.back();
  //               controller.pickProfilePhoto();
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
