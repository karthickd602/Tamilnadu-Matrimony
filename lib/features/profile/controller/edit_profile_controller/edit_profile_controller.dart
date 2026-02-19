import 'dart:convert';
import 'dart:io';

import 'package:tamilnadu_matrimony/common/widgets/images/t_image_picker.dart';
import 'package:tamilnadu_matrimony/features/authentication/model/dropdown_model.dart';
import 'package:tamilnadu_matrimony/features/profile/controller/profile_controller.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../../../../utils/popups/full_screen_loader.dart';
import '../../../authentication/dropdown_list.dart';
import '../../model/user_profile_model.dart';
import '../../repository/profile_repository.dart';

class EditProfileController extends GetxController {
  static EditProfileController get instance => Get.find();
  final storage = GetStorage();

  final userProfile = Rxn<FetchUserProfileModel>();

  final repo = Get.put(ProfileRepository());
  final profileController = ProfileController.instance;

  // Total)
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
  // final noOfChildren = ''.obs;
  final selectedNoOfChildren = Rxn<ChildCountModel>();

  // final eduction = ''.obs;
  // final occupation  = ''.obs;
  final selectedEducation = Rxn<EducationDDModel>();
  final selectedOccupation = Rxn<OccupationDDModel>();
  final selectedReligion = Rxn<ReligionDDModel>();
  final selectedCaste = Rxn<CasteDDModel>();
  final selectedComplexion = ''.obs;
  final educationDetailsController = TextEditingController();
  final occupationDetailsController = TextEditingController();
  final incomeController = TextEditingController();

  final isDisablePerson = ''.obs;
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
  final expectationsController = TextEditingController();

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
  final selectedHeight = Rxn<HeightOption>();

  final heightList = ProfileDropdowns.heightList;
  final childCountList = ProfileDropdowns.childCountList;

  final raasiList = ProfileDropdowns.raasiList;
  final dasaList = ProfileDropdowns.dasaList;
  final dhosamList = ProfileDropdowns.dhosamList;
  final martialStatusList = ProfileDropdowns.martialStatusList;

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

  void onDoshamChanged(String? value) {
    areYouHaveDhosam.value = value;
    if (value == TTexts.yes.tr) {
      isDoshamHave.value = "Yes";
    } else {
      isDoshamHave.value = "No";
      selectedDhosam.value = null;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 100));
    await loadAllDropdownAndProfile();
  }

  Future<void> loadAllDropdownAndProfile() async {
    try {
      TFullScreenLoader.popUpCircular();
      await fetchOccupationDropdown();
      await fetchEducationDropdown();
      await fetchReligionDropdown();
      await fetchCountryDropdown();
      await fetchUserProfile();
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: "Failed",
        message: "Something went wrong, try again later",
      );
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;

      final userId = storage.read(TTexts.userId);
      // final userId = "96166";
      final response = await repo.fetchUserProfile(userId: userId);
      debugPrint("Edit Profile Response : $response");
      userProfile.value = FetchUserProfileModel.fromJson(response["data"]);

      if (isClosed) return;
      await _mapProfileToFields();
    } catch (e) {
      debugPrint("Profile Error : $e");
      TLoaders.errorSnackBar(title: "Profile Error", message: e.toString());
    } finally {
      isLoading.value = false;
      // TFullScreenLoader.stopLoading();
    }
  }

  Future<void> _mapProfileToFields() async {
    if (isClosed) return;
    final profile = userProfile.value;
    if (profile == null) return;

    /// ---------------- BASIC DETAILS ----------------

    /// split the child cound and living status
    String children = profile.childrenLivingStatus?.toString() ?? '';

    if (children.contains('-')) {
      final childrenList = children.split('-');

      if (childrenList.length > 1) {
        childLivingStatus.value = childrenList[1].trim().toLowerCase() == 'yes'
            ? 'Living with me'
            : 'Not living';
        selectedNoOfChildren.value = childCountList.firstWhereOrNull(
          (e) => e.id.toString() == childrenList[0].trim(),
        );
      } else {
        childLivingStatus.value = '';
      }
    } else {
      childLivingStatus.value = '';
    }

    nameController.text = profile.name ?? '';
    dobController.text = profile.dob ?? '';

    selectedGender.value = profile.gender == "1"
        ? TTexts.male.tr
        : TTexts.female.tr;

    maritalStatus.value = profile.maritalStatus == "Unmarried"
        ? TTexts.unMarried.tr
        : profile.maritalStatus == 'Separated'
        ? TTexts.separated.tr
        : profile.maritalStatus == 'Divorced'
        ? TTexts.divorced.tr
        : profile.maritalStatus == 'widowed'
        ? TTexts.widowed
        : '';
    selectedComplexion.value = profile.complexion ?? '';
    educationDetailsController.text = profile.educationDetails ?? '';
    subCasteController.text = profile.subCaste ?? '';
    incomeController.text = profile.annualIncome.toString();

    isDisablePerson.value = profile.speCases == "1"
        ? TTexts.yes.tr
        : TTexts.no.tr;

    /// ---------------- DROPDOWNS (MATCH BY ID) ----------------
    /// ---------------- DROPDOWNS ----------------

    await Future.delayed(const Duration(milliseconds: 100));
    occupationDetailsController.text = profile.workplace ?? '';
    debugPrint(
      'occupation Details : ${profile.workplace}---${occupationDetailsController.text}',
    );
    selectedEducation.value = educationDDList.firstWhereOrNull(
      (e) => e.id.toString() == profile.educationId,
    );

    selectedOccupation.value = occupationDDList.firstWhereOrNull(
      (e) => e.id.toString() == profile.occupationId,
    );

    /// ---------------- CASTE (DEPENDS ON RELIGION) ----------------
    selectedReligion.value = religionDDList.firstWhereOrNull(
      (e) => e.id.toString() == profile.religionId,
    );
    if (selectedReligion.value != null) {
      await fetchCasteDropdown(religionId: selectedReligion.value!.id);

      selectedCaste.value = casteDDList.firstWhereOrNull(
        (e) => e.id.toString() == profile.casteId,
      );

      selectedHeight.value = heightList.firstWhereOrNull(
        (e) => e.id.toString() == profile.heightID.toString(),
      );
      debugPrint("✅selected Caste ${selectedCaste.value}");
    }

    fatherNameController.text = profile.fatherName ?? '';
    fatherOccupationController.text = profile.fathersOccupation ?? '';
    motherNameController.text = profile.motherName ?? '';
    motherOccupationController.text = profile.mothersOccupation ?? '';
    familyStatusController.value = profile.familyStatus ?? '';
    brothersController.text = profile.noOfBrothers ?? '';
    sistersController.text = profile.noOfSisters ?? '';
    marriedBrothersController.text = profile.nbm ?? '';
    marriedSistersController.text = profile.nsm ?? '';
    nativePlaceController.text = profile.irupidam ?? '';
    selectedComplexion.value = profile.complexion ?? '';

    /// ---------------- LOCATION ----------------

    selectedCountry.value = countryList.firstWhereOrNull(
      (e) => e.id.toString() == profile.countryId,
    );

    if (selectedCountry.value != null) {
      await fetchStateDropdown();

      selectedState.value = stateList.firstWhereOrNull(
        (e) => e.id.toString() == profile.stateId,
      );
    }

    if (selectedState.value != null) {
      await fetchDistrictDropdown();

      selectedDistrict.value = districtList.firstWhereOrNull(
        (e) => e.id.toString() == profile.cityId,
      );
    }

    /// ---------------- CONTACT ----------------

    mobileController.text = profile.phone ?? profile.mobile ?? '';
    emailController.text = profile.confirmEmail ?? '';
    cityController.text = profile.city ?? '';
    stateController.value = profile.state ?? '';
    districtController.value = profile.city ?? '';
    pincodeController.text = profile.postal ?? '';
    addressController.text = profile.address ?? '';
    noCasteChecked.value = profile.noCaste.toString().toLowerCase() == "yes"
        ? true
        : false;

    /// ---------------- HOROSCOPE ----------------

    selectedRaasi.value = profile.moonsign;
    selectedStar.value = profile.star;
    selectedLaknam.value = profile.inLaknam ?? '';
    selectedDasa.value = profile.dasaType;
    selectedDhosam.value = profile.thosam;
    areYouHaveDhosam.value = profile.thoosamType == 'Yes'
        ? TTexts.yes.tr
        : TTexts.no.tr;
    isDoshamHave.value = profile.thoosamType ?? 'No';
    debugPrint(" dosham ${isDoshamHave.value}");

    /// ---------------- PROFILE IMAGE ----------------

    // if (profile.photo1 != null && profile.photo1!.isNotEmpty) {
    //   profileImagePath.value = profile.photo1!;
    // }

    debugPrint("✅ Profile mapped to form successfully");
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
      // TFullScreenLoader.popUpCircular();
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
    } finally {
      // TFullScreenLoader.stopLoading();
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
      // TFullScreenLoader.popUpCircular();

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
    } finally {
      // TFullScreenLoader.stopLoading();
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
      // TFullScreenLoader.popUpCircular();
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
    } finally {
      // TFullScreenLoader.stopLoading();
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
      // final childrenCount = selectedNoOfChildren.value?.label == '0'
      //     ? '0'
      //     : selectedNoOfChildren.value?.label == '1'
      //     ? 'One'
      //     : selectedNoOfChildren.value?.id == '2'
      //     ? 'Two'
      //     : selectedNoOfChildren.value?.id == '3'
      //     ? 'Three'
      //     : selectedNoOfChildren.value?.id == '4 and above'
      //     ? 'Four and above'
      //     : '';
      // debugPrint(
      //   'childrenCountsssss: $childrenCount  -- ${selectedNoOfChildren.value!.id}',
      // );
      final childLiving = childLivingStatus.value == "Living with me"
          ? "Yes"
          : "No";

      final request = {
        "ID": storage.read(TTexts.userId),
        "Name": nameController.text,
        "Gender": selectedGender.value == "Male" ? 1 : 2,
        "DOB": dob,
        "Height": selectedHeight.value?.id,
        "Complexion": selectedComplexion.value,
        "Maritalstatus": maritalStatus.value == TTexts.unMarried.tr
            ? "Unmarried"
            : maritalStatus.value == TTexts.separated.tr
            ? "Separated"
            : maritalStatus.value == TTexts.divorced.tr
            ? "Divorced"
            : maritalStatus.value == TTexts.widowed
            ? "Widowed"
            : maritalStatus.value,
        "childrenlivingstatus":
            "${selectedNoOfChildren.value?.id ?? '0'.toString()}-${childLiving.toString()}",
        // "childrenlivingstatus":
        //     int.tryParse(childLivingStatus.value.toString()) ?? 0,
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
        "Basic Edit Form Req ${ApiConstant.basicRegisterEndpoint}: $request",
      );

      final response = await THttpHelper.post(
        ApiConstant.basicRegisterEndpoint,
        request,
      );
      profileController.fetchUserProfile();

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

      if (int.parse(brothersController.text) <
          int.parse(marriedBrothersController.text)) {
        TLoaders.warningSnackBar(
          title: "Warning",
          message: "Married brother count is more than brother count",
        );
        return;
      }
      if (int.parse(sistersController.text) <
          int.parse(marriedSistersController.text)) {
        TLoaders.warningSnackBar(
          title: "Warning",
          message: "Married Sister count is more than sister count",
        );
        return;
      }
      isLoading.value = true;
      final request = {
        "id": storage.read(TTexts.userId),
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
      await profileController.fetchUserProfile();
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

      TFullScreenLoader.popUpCircular();
      if (!horoscopeFormKey.currentState!.validate()) {
        return;
      }

      // if (horoscopeImagePath.value.isEmpty) {
      //   TLoaders.warningSnackBar(
      //     title: "No Horoscope Image",
      //     message: "Please select horoscope image",
      //   );
      //   return;
      // }

      final file = File(horoscopeImageFile.value.path);
      if (!file.existsSync()) {
        TLoaders.warningSnackBar(
          title: "Error",
          message: "Image file not found",
        );
        return;
      }

      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);
      final extension = file.path.split('.').last.toLowerCase();
      String mimeType = "image/jpeg";
      if (extension == "png") mimeType = "image/png";

      final base64Image = "data:$mimeType;base64,$base64String";

      final request = {
        "id": storage.read(TTexts.userId),
        "choice": 4,
        'Moonsign': selectedRaasi.value,
        "Star": selectedStar.value,
        "InLaknam": selectedLaknam.value,
        "dasatype": selectedDasa.value,
        "thoosamtype": isDoshamHave.value,
        "thosam": selectedDhosam.value,
        "file": base64Image,
      };
      debugPrint("Horoscope req : $request");

      final res = await THttpHelper.post(
        ApiConstant.horoscopeEditEndpoint,
        request,
      );
      debugPrint("Horoscope res : $res");
      await profileController.fetchUserProfile();
      TLoaders.successSnackBar(title: "Success", message: res['message']);

      currentStep.value++;
    } catch (e) {
      debugPrint("horoscopeFormSubmit - $e");

      TLoaders.errorSnackBar(
        title: "Failed",
        message:
            "Something went wrong in Horoscope Details submit, try again later",
      );
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> contactFormSubmit() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      TFullScreenLoader.popUpCircular();
      if (!contactFormKey.currentState!.validate()) {
        return;
      }
      final request = {
        "id": storage.read(TTexts.userId),
        "Phone": alternateMobileController.text,
        "ConfirmEmail": emailController.text,
        "Address": addressController.text,
        "Country": selectedCountry.value?.id,
        "State": selectedState.value?.id,
        "City": selectedDistrict.value?.id,
        "Postal": pincodeController.text,
        "expectations": expectationsController.text,
        "nocaste": noCasteChecked.value ? "no_caste" : "",
      };

      debugPrint("Contact req : $request");

      final response = await THttpHelper.post(
        ApiConstant.contactRegisterEndpoint,
        request,
      );
      //
      // final response = await THttpHelper.multipartPost(
      //   filePath: profileImageFile.value.path,
      //   ApiConstant.contactRegisterEndpoint,
      //   request,
      //   fileFieldName: "photo1",
      // );
      debugPrint("Contact Register Response : $response");
      await profileController.fetchUserProfile();
      TLoaders.successSnackBar(title: "Success", message: response['message']);
      Get.offNamed(TRoutes.viewProfile);
      // storage.write(TTexts.appPages, 0);
      // Get.offAllNamed(TRoutes.bottomNav);
    } catch (e) {
      debugPrint("contactFormSubmit - $e");
      TLoaders.errorSnackBar(
        title: "Failed",
        message:
            "Something went wrong in Contact Details submit, try again later",
      );
    } finally {
      TFullScreenLoader.stopLoading();
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
    expectationsController.dispose();
    super.onClose();
  }
}

//
// class HeightOption {
//   final int id;
//   final String label;
//
//   HeightOption({required this.id, required this.label});
// }
//
// class ChildCountModel {
//   final String id;
//   final String label;
//
//   ChildCountModel({required this.id, required this.label});
// }
