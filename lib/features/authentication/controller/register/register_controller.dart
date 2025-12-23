import 'dart:io';

import 'package:tamilnadu_matrimony/common/widgets/images/t_image_picker.dart';
import 'package:tamilnadu_matrimony/features/authentication/model/dropdown_model.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();
  final storage = GetStorage();

  String userId = "";

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
  final isLoading = false.obs;

  // Basic Details fields
  final nameController = TextEditingController();
  final selectedGender = ''.obs;
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
  final selectedLaknam = ''.obs;
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
  final genderList = [TTexts.male.tr, TTexts.female.tr].obs;

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

  // Pick horoscope image
  void selectHoroscopeImage(BuildContext context) async {
    final file = await TImagePickerHelper.pickProfilePhoto(context);
    if (file != null) {
      horoscopeImageFile.value = file;
      horoscopeImagePath.value = file.path;
    }
  } // Pick Contact image

  void selectProfileImage(BuildContext context) async {
    final file = await TImagePickerHelper.pickProfilePhoto(context);
    if (file != null) {
      profileImageFile.value = file;
      profileImagePath.value = file.path;
    }
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

      isLoading.value = true;

      final dob = THelperFunctions.convertDateFormat(
        dobController.text,
        fromFormat: 'dd-MM-yyyy',
        toFormat: 'yyyy-MM-dd',
      );
      final request = {
        "Name": nameController.text,
        "Gender": selectedGender.value == "Male" ? 1 : 2,
        "DOB": dob,
        "Height": heightController.text,
        "Complexion": colorComplexion.value,
        "Maritalstatus": maritalStatus.value,
        "childrenlivingstatus":
            int.tryParse(childLivingStatus.value.toString()) ?? 0,
        "Religion": selectedReligion.value?.id ?? 0,
        "Caste": selectedCaste.value?.id ?? 0,
        "Education": selectedEducation.value?.id ?? 0,
        "EducationDetails": educationDetailsController.text,
        "Occupation": selectedOccupation.value?.id ?? 0,
        "workplace": occupationDetailsController.text,
        "Annualincome": int.tryParse(incomeController.text) ?? 0,
        "Subcaste": subCasteController.text,
        "spe_cases": isDisablePerson.value.toString() == "Yes" ? 1 : 0,
      };

      debugPrint(
        "Basic Register ${ApiConstant.basicRegisterEndpoint}: $request",
      );

      final response = await THttpHelper.post(
        ApiConstant.basicRegisterEndpoint,
        request,
      );

      userId = response['data']['ID'].toString();

      await storage.write(TTexts.userId, userId);

      TLoaders.successSnackBar(title: "Success", message: response['message']);

      debugPrint("Basic Register Response : $response");

      currentStep.value++;
    } catch (e) {
      debugPrint("basicFormSubmit - $e");
      TLoaders.errorSnackBar(
        title: "Failed",
        message:
            "Something went wrong in Basic Details submit, try again later",
      );
    } finally {
      isLoading.value = false;
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

      isLoading.value = true;
      final request = {
        "id": userId,
        "Fathername": fatherNameController.text,
        "Fathersoccupation": fatherOccupationController.text,
        "Mothersname": motherNameController.text,
        "Mothersoccupation": motherOccupationController.text,
        "FamilyStatus": familyStatusController.value,
        "noofbrothers": brothersController.text,
        "noofsisters": sistersController.text,
        "nbm": marriedBrothersController.text,
        "nsm": marriedSistersController.text,
        "irupidam": nativePlaceController.text,
        "property": "",
      };
      debugPrint('Family Register reqq $request');

      final response = await THttpHelper.post(
        ApiConstant.familyRegisterEndpoint,
        request,
      );

      debugPrint("Family Register Response : $response");
      TLoaders.successSnackBar(title: "Success", message: response['message']);
      currentStep.value++;
    } catch (e) {
      debugPrint("familyFormSubmit - $e");
      TLoaders.errorSnackBar(
        title: "Failed",
        message:
            "Something went wrong in Family Details submit, try again later",
      );
    } finally {
      isLoading.value = false;
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

      if (horoscopeImagePath.value.isEmpty) {
        TLoaders.warningSnackBar(
          title: "No Horoscope Image",
          message: "Please select horoscope image",
        );
        return;
      }
      final request = {
        "id": userId,
        // "id": "96142",
        'Moonsign': selectedRaasi.value,
        "Star": selectedStar.value,
        "InLaknam": selectedLaknam.value,
        "dasatype": selectedDasa.value,
        "thoosamtype": isDoshamHave.value,
        "thosam": selectedDhosam.value,
      };
      debugPrint("Horoscope req : $request");

      final res = await THttpHelper.multipartPost(
        filePath: horoscopeImageFile.value.path,
        ApiConstant.horoscopeRegisterEndpoint,
        request,
      );
      debugPrint("Horoscope res : $request");

      TLoaders.successSnackBar(title: "Success", message: res['message']);

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
