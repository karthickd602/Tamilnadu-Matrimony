import 'package:tamilnadu_matrimony/features/profile/controller/profile_controller.dart';
import 'package:tamilnadu_matrimony/features/subscription/controller/subscription_controller.dart';

import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/dropdown_list.dart';
import '../../authentication/model/dropdown_model.dart';
import '../controller/dashboard_controller.dart';
import '../model/dashboard_list_model.dart';

class FilterController extends GetxController {
  final selectedIndex = 0.obs;
  final storage = GetStorage();

  /// MAIN CATEGORIES
  final filterCategories = [
    "Caste",
    "Age",
    "Education",
    "Marriage Type",
    // "Nakshatram",
    "Location",
    "Star",
    "Dosham",
    "No Caste Bar",
    "Disability",
  ].obs;

  /// DROPDOWN MODELS
  final casteList = <CasteDDModel>[].obs;
  final educationList = <EducationDDModel>[].obs;
  final districtList = <CountryModel>[].obs;
  final martialStatusList = [
    {'id': 1, 'name': TTexts.unMarried.tr},
    {'id': 2, 'name': TTexts.widowed.tr},
    {'id': 3, 'name': TTexts.divorced.tr},
    {'id': 4, 'name': TTexts.separated.tr},
  ].obs;

  final starList = ProfileDropdowns.allStarsList;

  final dhosamList = [
    {"id": 1, "name": "ராகு-கேது தோஷம்"},
    {"id": 2, "name": "செவ்வாய் தோஷம்"},
    {"id": 3, "name": "நாக தோஷம்"},
    {"id": 4, "name": "கால சர்ப்ப தோஷம்"},
  ].obs;

  /// AGE RANGE
  var ageRange = const RangeValues(18, 50).obs;

  /// SELECTED FILTER DATA
  /// → Checkbox : List<int>
  /// → Radio : int
  final selectedOptions = <String, dynamic>{}.obs;

  final profileController = Get.put(ProfileController());

  @override
  void onInit() async {
    super.onInit();
    // Silent check for subscription status
    SubscriptionController.shouldNavigate = false;
    final subController = Get.put(SubscriptionController());
    SubscriptionController.shouldNavigate = true;
    await subController.checkSubscriptionStatusSilent();

    await profileController.fetchUserProfile();
    final profile = profileController.userProfile.value;

    await fetchCasteFilter(
      religionId: profile?.religionId ?? '0',
      showLoader: false,
    );
    await fetchDistrictDropdown(
      stateId: profile?.stateId ?? "0",
      showLoader: false,
    );
  } // --------------------------------------------------------------
  // API CALLS
  // --------------------------------------------------------------

  /// 🔹 Caste Fetch
  Future<void> fetchCasteFilter({
    required String religionId,
    bool showLoader = true,
  }) async {
    try {
      if (casteList.isNotEmpty) return;
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        if (showLoader) {
          TLoaders.warningSnackBar(
            title: "No Internet",
            message: "Check connection",
          );
        }
        return;
      }

      if (showLoader) TFullScreenLoader.popUpCircular();

      final req = {"religion_id": religionId};

      appDebugPrint("fetchCasteFilter req :$req");
      final response = await THttpHelper.post(ApiConstant.getCasteDD, req);
      appDebugPrint("fetchCasteFilter res $response");
      if (response['statusCode'] == 200) {
        casteList.value = (response['data'] as List)
            .map((e) => CasteDDModel.fromJson(e))
            .toList();
      }

      if (showLoader) TFullScreenLoader.stopLoading();
    } catch (e) {
      if (showLoader) TFullScreenLoader.stopLoading();
      appDebugPrint("fetchCasteFilter Error: $e");
    }
  }

  /// 🔹 Education Fetch
  Future<void> fetchEducationFilter({bool showLoader = true}) async {
    try {
      if (educationList.isNotEmpty) return;

      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        if (showLoader) {
          TLoaders.warningSnackBar(
            title: "No Internet",
            message: "Check connection",
          );
        }
        return;
      }

      if (showLoader) TFullScreenLoader.popUpCircular();

      final response = await THttpHelper.get(ApiConstant.getEducationDD);

      if (response['statusCode'] == 200) {
        educationList.value = (response['data'] as List)
            .map((e) => EducationDDModel.fromJson(e))
            .toList();
      }

      if (showLoader) TFullScreenLoader.stopLoading();
    } catch (e) {
      if (showLoader) TFullScreenLoader.stopLoading();
      appDebugPrint("fetchEducationFilter Error: $e");
    }
  }

  /// 🔹 District Fetch
  Future<void> fetchDistrictDropdown({
    required String stateId,
    bool showLoader = true,
  }) async {
    try {
      if (districtList.isNotEmpty) return;
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) return;

      final req = {"state_id": stateId};
      appDebugPrint("fetchDistrictDropdown req :$req");
      final response = await THttpHelper.post(ApiConstant.getCityDD, req);

      if (response['statusCode'] == 200) {
        districtList.value = (response['data'] as List)
            .map((e) => CountryModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      appDebugPrint("fetchDistrictDropdown Error: $e");
    }
  }

  // --------------------------------------------------------------
  // SELECTION LOGIC
  // --------------------------------------------------------------

  /// MULTIPLE (CHECKBOX)
  void toggleCheckbox(String category, int id, {String? value}) {
    List<dynamic> list = List<dynamic>.from(selectedOptions[category] ?? []);

    if (category == "Star" && value != null) {
      if (list.contains(value)) {
        list.remove(value);
      } else {
        list.add(value);
      }
    } else {
      if (list.contains(id)) {
        list.remove(id);
      } else {
        list.add(id);
      }
    }

    selectedOptions[category] = list;
    appDebugPrint("✅ Selected $category: $list");
  }

  /// Return selected count or indicator for category
  String? getCategoryBadge(String category) {
    final value = selectedOptions[category];

    if (value == null) return null;

    // Checkbox category → List<int>
    if (value is List) {
      return value.isEmpty ? null : value.length.toString();
    }

    // Radio category → int
    if (value is int) {
      return value == 0 ? null : "✔";
    }

    return null;
  }

  /// Get custom badge for Age
  String? getAgeBadge() {
    final start = ageRange.value.start.toInt();
    final end = ageRange.value.end.toInt();

    // Default range → don't show badge
    if (start == 18 && end == 50) return null;

    return "$start–$end";
  }

  bool isCheckboxSelected(String category, int id, {String? value}) {
    // For string-based lists like Star, we might need to check by value if ID isn't available/unique
    if (category == "Star" && value != null) {
      final list = selectedOptions[category] ?? [];
      return list.contains(value);
    }
    return (selectedOptions[category] ?? []).contains(id);
  }

  /// SINGLE (RADIO)
  void selectRadio(String category, int id) {
    selectedOptions[category] = id;
  }

  bool isRadioSelected(String category, int id) {
    return selectedOptions[category] == id;
  }

  /// 🔹 Change active category
  void changeCategory(int index) {
    selectedIndex.value = index;
    update();
  }

  final lockedCategories = [""].obs;

  /// 🔹 Check if category is locked
  bool isLocked(String category) {
    if (lockedCategories.contains(category)) return true;

    // These categories are locked for unsubscribed users
    final lockedForUnsubscribed = ["Age", "Location", "Disability", "Star"];
    if (lockedForUnsubscribed.contains(category)) {
      final subController = Get.find<SubscriptionController>();
      return !subController.isSubscribed.value;
    }

    return false;
  }

  int getOptionId(dynamic option) {
    if (option is Map) return option["id"];
    if (option is String) {
      return 0;
    }
    return option.id; // model
  }

  String getOptionName(dynamic option) {
    if (option is Map) return option["name"];
    if (option is String) {
      return option;
    }
    return option.name; // model
  }

  // --------------------------------------------------------------
  // FINAL FILTER REQUEST
  // --------------------------------------------------------------

  Future<Map<String, dynamic>> fetchFilter() async {
    final selectedMarriageIds = selectedOptions["Marriage Type"];
    String selectedMartial = "";

    if (selectedMarriageIds != null && selectedMarriageIds is List) {
      final List<String> statusList = [];
      for (var id in selectedMarriageIds) {
        if (id == 1) statusList.add("Unmarried");
        if (id == 2) statusList.add("Widowed");
        if (id == 3) statusList.add("Divorced");
        if (id == 4) statusList.add("Separated");
      }
      selectedMartial = statusList.join(",");
    }

    return {
      "id": storage.read(TTexts.userId),
      "Caste": (selectedOptions["Caste"] as List? ?? []).join(","),
      "Education": (selectedOptions["Education"] as List? ?? []).join(","),
      "City": (selectedOptions["Location"] as List? ?? []).join(","),
      "thosam": _getDoshamNames().join(","),
      "Star": (selectedOptions["Star"] as List? ?? []).join(","),
      "Maritalstatus": selectedMartial,
      "nocaste": selectedOptions["No Caste Bar"] == 1 ? 'no_caste' : '',
      "spe_cases": selectedOptions["Disability"] == 1 ? "ஆம்" : "",
      "from_age": ageRange.value.start.toInt(),
      "to_age": ageRange.value.end.toInt(),
    };
  }

  // --------------------------------------------------------------
  // APPLY FILTER
  // --------------------------------------------------------------

  void applyFilter() async {
    final dashboard = DashboardController.instance;

    final filterReq = await fetchFilter();
    appDebugPrint("filterReq: $filterReq");
    dashboard.fetchDashboardCustomerProfile(
      isInitial: true,
      filters: filterReq,
    );

    Get.back();
  }

  // --------------------------------------------------------------
  // RESET FILTERS
  // --------------------------------------------------------------
  void resetFilters() {
    ageRange.value = const RangeValues(18, 50);
    selectedOptions.clear();
    selectedIndex.value = 0;

    // 🔥 Also reset stored filters in DashboardController
    final dashboard = DashboardController.instance;
    dashboard.fetchDashboardCustomerProfile(isInitial: true, filters: {});
  }

  List<String> _getDoshamNames() {
    final selectedIds = List<dynamic>.from(selectedOptions["Dosham"] ?? []);
    if (selectedIds.isEmpty) return [];

    return dhosamList
        .where((e) => selectedIds.contains(e["id"]))
        .map((e) => e["name"].toString())
        .toList();
  }

  // --------------------------------------------------------------
  // SPECIAL FILTER LOGIC
  // --------------------------------------------------------------
  final specialFilterProfiles = <CustomerProfileListModel>[].obs;
  final isSpecialLoading = false.obs;
  final RxString selectedSpecialCategory = "".obs;

  void setSpecialFilter(String type) {
    if (selectedSpecialCategory.value == type) {
      selectedSpecialCategory.value = "";
      specialFilterProfiles.clear();
      return;
    }

    selectedSpecialCategory.value = type;
    fetchSpecialFilterProfiles();
  }

  Future<void> fetchSpecialFilterProfiles() async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Check connection",
        );
        return;
      }

      isSpecialLoading.value = true;
      specialFilterProfiles.clear();

      Map<String, dynamic> req = {"id": storage.read(TTexts.userId)};

      switch (selectedSpecialCategory.value) {
        case "unmarried":
          req["Maritalstatus"] = "Unmarried";
          break;
        case "no_caste":
          req["nocaste"] = "no_caste";
          break;
        case "disable_person":
          req["spe_cases"] = "ஆம்";
          break;
        case "dhosam_having":
          req["thoosamtype"] = "ஆம்";
          break;
        default:
          isSpecialLoading.value = false;
          return;
      }

      appDebugPrint("fetchSpecialFilterProfiles req: $req");
      final response = await THttpHelper.post(
        ApiConstant.specialFilterEndPoint,
        req,
      );
      appDebugPrint("fetchSpecialFilterProfiles res: $response");

      if (response['statusCode'] == 200) {
        final List profiles = response['profiles'] ?? [];
        specialFilterProfiles.value = profiles
            .map((e) => CustomerProfileListModel.fromJson(e))
            .toList();

        if (specialFilterProfiles.isEmpty) {
          // No profiles found
        }
      }

      isSpecialLoading.value = false;
    } catch (e) {
      isSpecialLoading.value = false;
      TLoaders.errorSnackBar(
        title: "Special Filter Failed",
        message: e.toString(),
      );
    }
  }
}
