import '../../../utils/constants/path_provider.dart';
import '../../../utils/popups/full_screen_loader.dart';
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
    "Nakshatram",
    "Location",
    "Dosham",
    "No Caste Bar",
    "Disability",
  ].obs;

  /// DROPDOWN MODELS
  final casteList = <CasteDDModel>[].obs;
  final educationList = <EducationDDModel>[].obs;
  final districtList = <CountryModel>[].obs;
final martialStatus = [
  {"id": 1, "name": "First Marriage"},
  {"id": 2, "name": "Second Marriage"},
].obs;
  /// DOSHAM STATIC
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

  // --------------------------------------------------------------
  // INIT
  // --------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    fetchCasteFilter(religionId: 1);
  }

  // --------------------------------------------------------------
  // API CALLS
  // --------------------------------------------------------------

  /// 🔹 Caste Fetch
  Future<void> fetchCasteFilter({required int religionId}) async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(
            title: "No Internet", message: "Check connection");
        return;
      }

      TFullScreenLoader.popUpCircular();

      final req = {"religion_id": religionId};
      final response = await THttpHelper.post(ApiConstant.getCasteDD, req);

      if (response['statusCode'] == 200) {
        casteList.value = (response['data'] as List)
            .map((e) => CasteDDModel.fromJson(e))
            .toList();
      }

      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Caste Fetch Failed", message: e.toString());
    }
  }

  /// 🔹 Education Fetch
  Future<void> fetchEducationFilter() async {
    try {
      if (educationList.isNotEmpty) return;

      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(
            title: "No Internet", message: "Check connection");
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
          title: "Education Fetch Failed", message: e.toString());
    }
  }

  /// 🔹 District Fetch
  Future<void> fetchDistrictDropdown() async {
    try {
      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TLoaders.warningSnackBar(
            title: "No Internet", message: "Check connection");
        return;
      }

      final req = {"state_id": 35};
      final response = await THttpHelper.post(ApiConstant.getCityDD, req);

      if (response['statusCode'] == 200) {
        districtList.value = (response['data'] as List)
            .map((e) => CountryModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "District Fetch Failed", message: e.toString());
    }
  }

  // --------------------------------------------------------------
  // SELECTION LOGIC
  // --------------------------------------------------------------

  /// MULTIPLE (CHECKBOX)
  void toggleCheckbox(String category, int id) {
    final List<int> list = List<int>.from(selectedOptions[category] ?? []);

    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }

    selectedOptions[category] = list;
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


  bool isCheckboxSelected(String category, int id) {
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
  final lockedCategories = ["Nakshatram", ].obs;

  /// 🔹 Check if category is locked
  bool isLocked(String category) {
    return lockedCategories.contains(category);
  }
  int getOptionId(dynamic option) {
    if (option is Map) return option["id"];
    return option.id; // model
  }

  String getOptionName(dynamic option) {
    if (option is Map) return option["name"];
    return option.name; // model
  }

  // --------------------------------------------------------------
  // FINAL FILTER REQUEST
  // --------------------------------------------------------------

  Future<Map<String, dynamic>> fetchFilter() async {
    return {
      "id": storage.read(TTexts.userId),
      "Caste": selectedOptions["Caste"] ?? [],
      "EducationDetails": selectedOptions["Education"] ?? [],
      "City": selectedOptions["Location"] ?? [],
      "thosam": selectedOptions["Dosham"] ?? [],
      "Maritalstatus": selectedOptions["Marriage Type"] ?? 0,
      "no_caste_bar": selectedOptions["No Caste Bar"] ?? 0,
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

    dashboard.fetchDashboardCustomerProfile(
        isInitial: true, filters: filterReq);

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

}
