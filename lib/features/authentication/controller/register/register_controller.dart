import 'package:image_picker/image_picker.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();

  // Total steps
  final totalSteps = 4;

  // Step index
  RxInt currentStep = 0.obs;

  // Form keys
  final basicFormKey = GlobalKey<FormState>();
  final familyFormKey = GlobalKey<FormState>();
  final horoscopeFormKey = GlobalKey<FormState>();
  final contactFormKey = GlobalKey<FormState>();

  // Basic Details fields
  final nameController = TextEditingController();
  final gender = ''.obs;
  final dobController = TextEditingController();
  final dotController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final maritalStatus = ''.obs;
  final noOfChildren = ''.obs;
  final eduction = ''.obs;
  final occupation  = ''.obs;
  final colorComplexion  = ''.obs;
  final educationDetailsController = TextEditingController();
  final occupationDetailsController = TextEditingController();
  final incomeController = TextEditingController();
  final religion = ''.obs;
  final isDisablePerson = 'No'.obs;
  final caste = ''.obs;
  final subCasteController = TextEditingController();

  // Family Details fields
  final fatherNameController = TextEditingController();
  final fatherOccupationController = TextEditingController();
  final motherNameController = TextEditingController();
  final motherOccupationController = TextEditingController();
  final familyStatusController = TextEditingController();
  final familyTypeController = TextEditingController();
  final brothersController = TextEditingController();
  final sistersController = TextEditingController();
  final nativePlaceController = TextEditingController();


  // Horoscope fields
  final rasiController = "".obs;
  final nakshatraController = TextEditingController();
  final laknamController = ''.obs;
  RxString dosham = ''.obs;
  final dasaType = ''.obs;
  final dasaBalanceDays = TextEditingController();
  RxString horoscopeImagePath = ''.obs;


  final mobileController = TextEditingController();
  final whatsappController = TextEditingController();
  final alternateMobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  RxString profileImagePath = ''.obs;

  final noCasteChecked = false.obs;

  void submitRegistration() {
    // You can handle API call or summary review here
    debugPrint("Registration Submitted Successfully ✅");
  }

  // Pick horoscope image

  Future<void> pickImage(ImageSource source,{required RxString imagePath}) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      imagePath.value = picked.path;
    }
  }
  void showImageSourceSheet({required RxString imagePath}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                pickImage(ImageSource.camera,imagePath: imagePath);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                pickImage(ImageSource.gallery,imagePath: imagePath);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
  Future<void> basicFormSubmit() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      if (!basicFormKey.currentState!.validate()) {
        return;
      }

      final request = {
        "name": nameController.text,
        "gender": gender.value,
        "dob": dobController.text,
        "dot":dotController.text,
        "height": heightController.text,
        "weight": weightController.text,
        "marital_status": maritalStatus.value,
        "education": educationDetailsController.text,
        "occupation": occupationDetailsController.text,
        "income": incomeController.text,
        "religion": religion.value,
        "caste": caste.value,
        "sub_caste": subCasteController.text,
      };
      print("Basic : $request");
      currentStep.value++;
    } catch (e) {
      debugPrint("basicFormSubmit - ${e}");
      TLoaders.errorSnackBar(
        title: "Failed",
        message:
            "Something went wrong in Basic Details submit, try again later",
      );
    }
  }
  Future<void> familyFormSubmit() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      if (!familyFormKey.currentState!.validate()) {
        return;


      }
      final request = {
        "father_name": fatherNameController.text,
        "father_occupation": fatherOccupationController.text,
        "mother_name": motherNameController.text,
        "mother_occupation": motherOccupationController.text,
        "family_status": familyStatusController.text,
        "family_type": familyTypeController.text,
        "brothers": brothersController.text,
        "sisters": sistersController.text,
        "native_place": nativePlaceController.text,

      };
      currentStep.value++;

      print("Family : $request");
    }
    catch(e){
      debugPrint("familyFormSubmit - ${e}");
      TLoaders.errorSnackBar(
        title: "Failed",
        message:
        "Something went wrong in Family Details submit, try again later",
      );
    }
  }

  Future<void> horoscopeFormSubmit() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }


      if (!horoscopeFormKey.currentState!.validate()) {
        return;
      }
      final request = {
        "rasi": rasiController.value,
        "nakshatra": nakshatraController.text,
        "gothram": laknamController.value,
        "dosham": dosham.value,
        "horoscope_image": horoscopeImagePath.value,
      };
      print("Horoscope : $request");

      currentStep.value++;
    }
    catch(e){
      debugPrint("horoscopeFormSubmit - ${e}");

      TLoaders.errorSnackBar(
        title: "Failed",
        message:
        "Something went wrong in Horoscope Details submit, try again later",
      );

    }
  }

  Future<void> contactFormSubmit() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      if (!contactFormKey.currentState!.validate()) {
        return;
      }
      final request = {
        "mobile": mobileController.text,
        "whatsapp": whatsappController.text,
        "alternate_mobile": alternateMobileController.text,
        "email": emailController.text,
        "address": addressController.text,
        "city": cityController.text,
        "district": districtController.text,
        "state": stateController.text,
        "pincode": pincodeController.text,
      };
      print("Contact : $request");
      submitRegistration();
    Get.offAllNamed(TRoutes.bottomNav);
      }
      catch(e){
      debugPrint("contactFormSubmit - ${e}");
        TLoaders.errorSnackBar(title: "Failed", message: "Something went wrong in Contact Details submit, try again later");
    }
  }

  // Move to next step
  // void nextStep() {
  //   if (basicFormKey.currentState?.validate() ?? false) {
  //     currentStep.value++;
  //   }
  // }

  // Go back
  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  @override
  void onClose() {
    nameController.dispose();
    heightController.dispose();
    weightController.dispose();
    educationDetailsController.dispose();
    occupationDetailsController.dispose();
    incomeController.dispose();
    subCasteController.dispose();
    super.onClose();
  }
}
