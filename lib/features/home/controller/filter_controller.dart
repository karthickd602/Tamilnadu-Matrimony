import 'package:tamilnadu_matrimony/features/profile/controller/profile_controller.dart';

import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/dropdown_list.dart';
import '../../authentication/model/dropdown_model.dart';
import '../controller/dashboard_controller.dart';

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

  // final martialStatus = [
  //   // TTexts.unMarried.tr,
  //   // TTexts.widowed.tr,
  //   // TTexts.divorced.tr,
  //   // TTexts.separated.tr,
  // ].obs;
  // final martialStatus = [
  //   {"id": 1, "name": "First Marriage"},
  //   {"id": 2, "name": "Second Marriage"},
  // ].obs;

  /// DOSHAM STATIC

  // final dhosamList = [
  //   {"id": "ராகு-கேது தோஷம்", "name": "ராகு-கேது தோஷம்"},
  //   {"id": "செவ்வாய் தோஷம்", "name": "செவ்வாய் தோஷம்"},
  //   {"id": "நாக தோஷம்", "name": "நாக தோஷம்"},
  //   {"id": "கால சர்ப்ப தோஷம்", "name": "கால சர்ப்ப தோஷம்"},
  // ].obs;

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

  // --------------------------------------------------------------
  // API CALLS
  // --------------------------------------------------------------

  /// 🔹 Caste Fetch
  Future<void> fetchCasteFilter({required String religionId}) async {
    try {
      if (casteList.isNotEmpty) return;
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Check connection",
        );
        return;
      }

      TFullScreenLoader.popUpCircular();

      final req = {"religion_id": religionId};

      debugPrint("fetchCasteFilter req :$req");
      final response = await THttpHelper.post(ApiConstant.getCasteDD, req);
      debugPrint("fetchCasteFilter res $response");
      if (response['statusCode'] == 200) {
        casteList.value = (response['data'] as List)
            .map((e) => CasteDDModel.fromJson(e))
            .toList();
      }

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: "Caste Fetch Failed",
        message: e.toString(),
      );
    }
  }

  /// 🔹 Education Fetch
  Future<void> fetchEducationFilter() async {
    try {
      if (educationList.isNotEmpty) return;

      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Check connection",
        );
        return;
      }

      TFullScreenLoader.popUpCircular();

      final response = await THttpHelper.get(ApiConstant.getEducationDD);

      if (response['statusCode'] == 200) {
        educationList.value = (response['data'] as List)
            .map((e) => EducationDDModel.fromJson(e))
            .toList();
      }

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: "Education Fetch Failed",
        message: e.toString(),
      );
    }
  }

  /// 🔹 District Fetch
  Future<void> fetchDistrictDropdown({required String stateId}) async {
    try {
      if (districtList.isNotEmpty) return;
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Check connection",
        );
        return;
      }

      final req = {"state_id": stateId};
      debugPrint("fetchDistrictDropdown req :$req");
      final response = await THttpHelper.post(ApiConstant.getCityDD, req);

      if (response['statusCode'] == 200) {
        districtList.value = (response['data'] as List)
            .map((e) => CountryModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "District Fetch Failed",
        message: e.toString(),
      );
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
    debugPrint("✅ Selected $category: $list");
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
    return lockedCategories.contains(category);
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
      "Caste": selectedOptions["Caste"] ?? [],
      "EducationDetails": selectedOptions["Education"] ?? [],
      "City": selectedOptions["Location"] ?? [],
      "thosam": _getDoshamNames(),
      "star": selectedOptions["Star"] ?? [],
      "Maritalstatus": selectedMartial,
      "no_caste_bar": selectedOptions["No Caste Bar"] == 1 ? 'no_caste' : '',
      "disability": selectedOptions["Disability"] ?? 0,
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
    debugPrint("filterReq: $filterReq");
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
  }

  List<String> _getDoshamNames() {
    final selectedIds = List<dynamic>.from(selectedOptions["Dosham"] ?? []);
    if (selectedIds.isEmpty) return [];

    return dhosamList
        .where((e) => selectedIds.contains(e["id"]))
        .map((e) => e["name"].toString())
        .toList();
  }
}
