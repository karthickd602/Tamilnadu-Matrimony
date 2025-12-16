import 'dart:io';

import 'package:tamilnadu_matrimony/common/widgets/images/t_image_picker.dart';
import 'package:tamilnadu_matrimony/features/authentication/model/dropdown_model.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();

  // Total steps
  final totalSteps = 4;

  // Step index
  RxInt currentStep = 0.obs;

  final occupationDDList = <OccupationDDModel>[].obs;
  final religionDDList = <ReligionDDModel>[].obs;
  final casteDDList = <CasteDDModel>[].obs;
  final educationDDList = <EducationDDModel>[].obs;

  // Form keys
  final basicFormKey = GlobalKey<FormState>();
  final familyFormKey = GlobalKey<FormState>();
  final horoscopeFormKey = GlobalKey<FormState>();
  final contactFormKey = GlobalKey<FormState>();

  // Basic Details fields
  final nameController = TextEditingController();
  final gender = ''.obs;
  final dobController = TextEditingController();
  final heightController = TextEditingController();
  final maritalStatus = ''.obs;
  final childLivingStatus = ''.obs;
  final noOfChildren = ''.obs;

  // final eduction = ''.obs;
  // final occupation  = ''.obs;
  final selectedEducation = Rxn<EducationDDModel>();
  final selectedOccupation = Rxn<OccupationDDModel>();
  final selectedReligion = Rxn<ReligionDDModel>();
  final selectedCaste = Rxn<CasteDDModel>();
  final colorComplexion = ''.obs;
  final educationDetailsController = TextEditingController();
  final occupationDetailsController = TextEditingController();
  final incomeController = TextEditingController();

  final isDisablePerson = 'No'.obs;
  final subCasteController = TextEditingController();

  // Family Details fields
  final fatherNameController = TextEditingController();
  final fatherOccupationController = TextEditingController();
  final motherNameController = TextEditingController();
  final motherOccupationController = TextEditingController();
  final familyStatusController = ''.obs;

  // final familyTypeController = TextEditingController();
  final brothersController = TextEditingController();
  final sistersController = TextEditingController();
  final marriedBrothersController = TextEditingController();
  final marriedSistersController = TextEditingController();
  final nativePlaceController = TextEditingController();

  // Horoscope fields
  final rasiController = "".obs;
  final nakshatraController = TextEditingController();
  final laknamController = ''.obs;
  RxString isDoshamHave = ''.obs;
  final doshamType = ''.obs;
  final dasaBalanceDays = TextEditingController();

  // RxString horoscopeImagePath = ''.obs;
  final horoscopeImageFile = File('').obs;
  RxString horoscopeImagePath = ''.obs;

  final mobileController = TextEditingController();
  final whatsappController = TextEditingController();
  final alternateMobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  RxString districtController = "".obs;
  RxString stateController = "".obs;
  final pincodeController = TextEditingController();

  final profileImageFile = File('').obs;
  RxString profileImagePath = ''.obs;

  final noCasteChecked = false.obs;

  final countryList = <CountryModel>[].obs;
  final selectedCountry = Rxn<CountryModel>();
  final stateList = <CountryModel>[].obs;
  final selectedState = Rxn<CountryModel>();
  final districtList = <CountryModel>[].obs;
  final selectedDistrict = Rxn<CountryModel>();

  /// --- Base Lists ---
  final raasiList = [
    "மேஷம்",
    "ரிஷபம்",
    "மிதுனம்",
    "கடகம்",
    "சிம்மம்",
    "கன்னி",
    "துலாம்",
    "விருச்சிகம்",
    "தனுசு",
    "மகரம்",
    "கும்பம்",
    "மீனம்",
  ];

  final starMap = {
    "மேஷம்": ["அசுபதி", "பரணி", "அனுஷம்", "கார்த்திகை -1ம் பாதம்"],
    "ரிஷபம்": [
      "கார்த்திகை -2ம் பாதம்",
      "கார்த்திகை -3ம் பாதம்",
      "கார்த்திகை -4ம் பாதம்",
      "ரோகிணி",
      "மிருக சீரிஷம் -1ம் பாதம்",
      "மிருக சீரிஷம் -2ம் பாதம்",
    ],
    "மிதுனம்": [
      "மிருக சீரிஷம் -3ம் பாதம்",
      "மிருக சீரிஷம் -4ம் பாதம்",
      "திருவாதிரை",
      "புனர்பூசம் -1ம் பாதம்",
      "புனர்பூசம் -2ம் பாதம்",
      "புனர்பூசம் -3ம் பாதம்",
    ],
    "கடகம்": ["புனர்பூசம் -4ம் பாதம்", "பூசம்", "ஆயில்யம்"],
    "சிம்மம்": ["மகம்", "பூரம்", "உத்திரம் -1ம் பாதம்"],
    "கன்னி": [
      "உத்திரம் -2ம் பாதம்",
      "உத்திரம் -3ம் பாதம்",
      "உத்திரம் -4ம் பாதம்",
      "அஸ்தம்",
      "சித்திரை -1,2ம் பாதம்",
    ],
    "துலாம்": [
      "சித்திரை -3ம் பாதம்",
      "சித்திரை -4ம் பாதம்",
      "சுவாதி",
      "விசாகம் -1ம் பாதம்",
      "விசாகம் -2ம் பாதம்",
      "விசாகம் -3ம் பாதம்",
    ],
    "விருச்சிகம்": ["விசாகம் -4ம் பாதம்", "அனுஷம்", "கேட்டை"],
    "தனுசு": ["மூலம்", "பூராடம்", "உத்திராடம் -1ம் பாதம்"],
    "மகரம்": [
      "உத்திராடம் -2ம் பாதம்",
      "உத்திராடம் -3ம் பாதம்",
      "உத்திராடம் -4ம் பாதம்",
      "திருவோணம்",
      "அவிட்டம் -1ம் பாதம்",
      "அவிட்டம் -2ம் பாதம்",
    ],
    "கும்பம்": [
      "அவிட்டம் -3ம் பாதம்",
      "அவிட்டம் -4ம் பாதம்",
      "சதயம்",
      "பூரட்டாதி -1ம் பாதம்",
      "பூரட்டாதி -2ம் பாதம்",
      "பூரட்டாதி -3ம் பாதம்",
    ],
    "மீனம்": ["பூரட்டாதி -4ம் பாதம்", "உத்திரட்டாதி", "ரேவதி"],
  };

  final dasaList = [
    "சூரிய மகா திசை",
    "சந்திர மகா திசை",
    "செவ்வாய் மகா திசை",
    "புதன் மகா திசை",
    "வியாழ மகா திசை",
    "சுக்கிர மகா திசை",
    "சனி மகா திசை",
    "ராகு மகா திசை",
    "கேது மகா திசை",
    "குரு மகா திசை",
  ];

  final dhosamList = [
    "ராகு-கேது தோஷம்",
    "செவ்வாய் தோஷம்",
    "நாக தோஷம்",
    "கால சர்ப்ப தோஷம்",
    "களத்திர தோஷம்",
    "பித்ரு தோஷம்",
    "இதர தோஷம்",
  ];

  /// --- Selected Values ---
  final selectedRaasi = RxnString();
  final selectedStar = RxnString();
  final selectedDasa = RxnString();
  final areYouHaveDhosam = RxnString();
  final selectedDhosam = RxnString();

  /// --- Dynamic lists ---
  List<String> get starsForSelectedRaasi => starMap[selectedRaasi.value] ?? [];

  List<String> get filteredDasaList => dasaList;

  List<String> get filteredDhosamList => dhosamList;

  /// --- Update functions ---
  void onRaasiChanged(String? value) {
    selectedRaasi.value = value;
    selectedStar.value = null;
    selectedDasa.value = null;
    selectedDhosam.value = null;
  }

  void onStarChanged(String? value) {
    selectedStar.value = value;
    selectedDasa.value = null;
    selectedDhosam.value = null;
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchOccupationDropdown();
    await fetchEducationDropdown();
    await fetchReligionDropdown();
    await fetchCountryDropdown();
  }




  Future<void> fetchOccupationDropdown() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      final response = await THttpHelper.get(ApiConstant.getOccupationDD);
      //
      debugPrint("occupation Response:${response.toString()}");
      if (response['statusCode'] == 200) {
        occupationDDList.value = (response['data'] as List)
            .map((e) => OccupationDDModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Occupation Dropdown Failed",
        message: e.toString(),
      );
    }
  }

  Future<void> fetchEducationDropdown() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      final response = await THttpHelper.get(ApiConstant.getEducationDD);
      //
      debugPrint("Education Response:${response.toString()}");
      if (response['statusCode'] == 200) {
        educationDDList.value = (response['data'] as List)
            .map((e) => EducationDDModel.fromJson(e))
            .toList();
      } else {
        educationDDList.value = <EducationDDModel>[];
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Education Dropdown Failed",
        message: e.toString(),
      );
    }
  }

  Future<void> fetchReligionDropdown() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      final response = await THttpHelper.get(ApiConstant.getReligionDD);
      //
      debugPrint("occupation Response:${response.toString()}");
      if (response['statusCode'] == 200) {
        religionDDList.value = (response['data'] as List)
            .map((e) => ReligionDDModel.fromJson(e))
            .toList();
      } else {
        religionDDList.value = <ReligionDDModel>[];
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Religion Dropdown Failed",
        message: e.toString(),
      );
    }
  }

  Future<void> fetchCasteDropdown({required int religionId}) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      final req = {"religion_id": religionId};
      final response = await THttpHelper.post(ApiConstant.getCasteDD, req);
      //
      debugPrint("occupation Response:${response.toString()}");
      if (response['statusCode'] == 200) {
        casteDDList.value = (response['data'] as List)
            .map((e) => CasteDDModel.fromJson(e))
            .toList();
      } else {
        casteDDList.value = <CasteDDModel>[];
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Caste Dropdown Issue",
        message: e.toString(),
      );
    }
  }

  Future<void> fetchCountryDropdown() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      // final req = {"religion_id": religionId};
      final response = await THttpHelper.get(ApiConstant.getCountryDD);
      //
      debugPrint("country Response:${response.toString()}");
      if (response['statusCode'] == 200) {
        countryList.value = (response['data'] as List)
            .map((e) => CountryModel.fromJson(e))
            .toList();
        // selectedCountry.value = countryList.where((e)=>e.id==101,);
      } else {
        countryList.value = <CountryModel>[];
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Caste Dropdown Issue",
        message: e.toString(),
      );
    }
  }

  Future<void> fetchStateDropdown() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      final req = {"country_id": selectedCountry.value?.id};
      final response = await THttpHelper.post(ApiConstant.getStateDD, req);
      //
      debugPrint("state Response:${response.toString()}");
      if (response['statusCode'] == 204) {
        stateList.value = <CountryModel>[];
        return;
      }
      stateList.value = (response['data'] as List)
          .map((e) => CountryModel.fromJson(e))
          .toList();
      // } else {
      //
      // }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "State Dropdown Issue",
        message: e.toString(),
      );
    }
  }

  Future<void> fetchDistrictDropdown() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      final req = {"state_id": selectedState.value?.id};
      final response = await THttpHelper.post(ApiConstant.getCityDD, req);
      //
      debugPrint("state Response:${response.toString()}");
      if (response['statusCode'] == 204) {
        districtList.value = <CountryModel>[];
        return;
      }
      districtList.value = (response['data'] as List)
          .map((e) => CountryModel.fromJson(e))
          .toList();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "District Dropdown Issue",
        message: e.toString(),
      );
    }
  }

  void submitRegistration() {
    // You can handle API call or summary review here
    debugPrint("Registration Submitted Successfully ✅");
  }

  // Pick horoscope image
  void selectHoroscopeImage(BuildContext context) async {
    final file = await TImagePickerHelper.pickImageFromUser(context);
    if (file != null) {
      horoscopeImageFile.value = file;
      horoscopeImagePath.value = file.path;
    }
  }// Pick Contact image
  void selectProfileImage(BuildContext context) async {
    final file = await TImagePickerHelper.pickImageFromUser(context);
    if (file != null) {
      profileImageFile.value = file;
      profileImagePath.value = file.path;
    }
  }

  // Future<void> pickImage(
  //   ImageSource source, {
  //   required RxString imagePath,
  // }) async {
  //   final picker = ImagePicker();
  //   final picked = await picker.pickImage(source: source);
  //   if (picked != null) {
  //     imagePath.value = picked.path;
  //   }
  // }
  //
  // void showImageSourceSheet({required RxString imagePath}) {
  //   Get.bottomSheet(
  //     Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //       ),
  //       child: Wrap(
  //         children: [
  //           ListTile(
  //             leading: const Icon(Icons.camera_alt),
  //             title: const Text('Camera'),
  //             onTap: () {
  //               pickImage(ImageSource.camera, imagePath: imagePath);
  //               Get.back();
  //             },
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.photo),
  //             title: const Text('Gallery'),
  //             onTap: () {
  //               pickImage(ImageSource.gallery, imagePath: imagePath);
  //               Get.back();
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<void> basicFormSubmit() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      if (!basicFormKey.currentState!.validate()) {
        return;
      }

      // final request = {
      //   // 'id': 0,
      //   "Name": nameController.text,
      //   // "Gender": gender.value,
      //   "Gender": "1",
      //   // "DOB": dobController.text,
      //   "DOB": '1996-02-01',
      //   "Height": heightController.text,
      //   "Complexion": colorComplexion.value,
      //   "Maritalstatus": maritalStatus.value,
      //   // "childCount": noOfChildren.value.isEmpty ? "0" : noOfChildren.value,
      //   "childrenlivingstatus": childLivingStatus.value,
      //   "Religion": selectedReligion.value?.id.toString(),
      //   "Caste": selectedCaste.value?.id.toString(),
      //   "Education": selectedEducation.value?.id.toString(),
      //   "EducationDetails": educationDetailsController.text,
      //   "occupation": selectedOccupation.value?.id.toString(),
      //   "workplace": occupationDetailsController.text,
      //   "Annualincome": incomeController.text,
      //   "Subcaste": subCasteController.text,
      //   "spe_cases": isDisablePerson.value,
      // };

      final request = {
        "Name": "raj",
        "Gender": "1",
        "DOB": "1996-02-01",
        "Height": "11",
        "Complexion": "மாநிறம்",
        "Maritalstatus": "துணையை இழந்தவர்",
        "childrenlivingstatus": "Living with me",
        "Religion": "2",
        "Caste": "100",
        "Education": "1",
        "EducationDetails": "fr",
        "occupation": "2",
        "workplace": "ttt",
        "Annualincome": "2222",
        "Subcaste": "tt",
        "spe_cases": "No"
      };

      debugPrint("Basic Register : $request");

      final response = await THttpHelper.post(
        ApiConstant.basicRegisterEndpoint,
        request,
      );

      debugPrint("Basic Register Response : $response");

      // currentStep.value++;
    } catch (e) {
      debugPrint("basicFormSubmit - $e");
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
        debugPrint("familyFormSubmit - validate");
        return;
      }

      debugPrint('"father_name": ${fatherNameController.text}');
      debugPrint('"father_occupation": ${fatherOccupationController.text}');
      debugPrint('"mother_name": ${motherNameController.text}');
      debugPrint('"mother_occupation": ${motherOccupationController.text}');
      debugPrint('"family_status": ${familyStatusController.value}');
      debugPrint('"brothers": ${brothersController.text}');
      debugPrint('"sisters": ${sistersController.text}');
      debugPrint('"married_brothers": ${marriedBrothersController.text}');
      debugPrint('"married_sisters": ${marriedSistersController.text}');
      debugPrint('"native_place": ${nativePlaceController.text}');

      final request = {
        "id": "11622",
        "Fathername": fatherNameController.text,
        "Fathersoccupation": fatherOccupationController.text,
        "Mothersname": motherNameController.text,
        "Mothersoccupation": motherOccupationController.text,
        // "family_status": familyStatusController.value,
        "noofbrothers": brothersController.text,
        "noofsisters": sistersController.text,
        "nbm": marriedBrothersController.text,
        "nsm": marriedSistersController.text,
        "irupidam": nativePlaceController.text,
      };
      debugPrint('Family Register reqq $request');

      final response = await THttpHelper.post(
        ApiConstant.familyRegisterEndpoint,
        request,
      );

      debugPrint("Family Register Response : $response");

      // currentStep.value++;

      print("Family : $request");
    } catch (e) {
      debugPrint("familyFormSubmit - $e");
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
        "id": "11622",
        "rasi": rasiController.value,
        "nakshatra": nakshatraController.text,
        "gothram": laknamController.value,
        "dosham": doshamType.value,
        "horoscope_image": horoscopeImagePath.value,
      };
      print("Horoscope : $request");

      currentStep.value++;
    } catch (e) {
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
        "district": districtController,
        "state": stateController,
        "pincode": pincodeController.text,
      };
      print("Contact : $request");
      submitRegistration();
      Get.offAllNamed(TRoutes.bottomNav);
    } catch (e) {
      debugPrint("contactFormSubmit - ${e}");
      TLoaders.errorSnackBar(
        title: "Failed",
        message:
            "Something went wrong in Contact Details submit, try again later",
      );
    }
  }

  // Go back
  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  @override
  void onClose() {
    nameController.dispose();
    heightController.dispose();
    educationDetailsController.dispose();
    occupationDetailsController.dispose();
    incomeController.dispose();
    subCasteController.dispose();
    super.onClose();
  }
}
