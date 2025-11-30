
import 'package:tamilnadu_matrimony/utils/popups/full_screen_loader.dart';

import '../../../utils/constants/path_provider.dart';
import '../../authentication/model/dropdown_model.dart';

class FilterController extends GetxController {
  // 🔹 Selected category index
  final selectedIndex = 0.obs;

  // 🔹 Categories
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
  final casteList = <CasteDDModel>[].obs;
  final educationList = <EducationDDModel>[].obs;

  final dhosamList = [
    "ராகு-கேது தோஷம்",
    "செவ்வாய் தோஷம்",
    "நாக தோஷம்",
    "கால சர்ப்ப தோஷம்",
    "களத்திர தோஷம்",
    "பித்ரு தோஷம்",
    "இதர தோஷம்"
  ];

  @override
  void onInit() async{
    super.onInit();
  await  fetchCasteFilter(religionId: 1); //
    // await fetchEducationDropdown();
  }

  Future<void> fetchCasteFilter({required int religionId}) async {
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
        casteList.value = (response['data'] as List)
            .map((e) => CasteDDModel.fromJson(e))
            .toList();
      } else {
        casteList.value = <CasteDDModel>[];
      }
      update();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Caste Dropdown Issue",
        message: e.toString(),
      );
    }
  }

  Future<void> fetchEducationFilter() async {
    try {
      if(educationList.isNotEmpty) return;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your Internet Connection",
        );
        return;
      }

      TFullScreenLoader.popUpCircular();

      final response = await THttpHelper.get(ApiConstant.getEducationDD);
      //
      debugPrint("Education Response:${response.toString()}");
      if (response['statusCode'] == 200) {
        educationList.value = (response['data'] as List)
            .map((e) => EducationDDModel.fromJson(e))
            .toList();
      } else {
        educationList.value = <EducationDDModel>[];
      }
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: "Education Dropdown Failed",
        message: e.toString(),
      );
    }
  }

  var ageRange = const RangeValues(18,50).obs;

  // 🔹 Locked categories
  final lockedCategories = [ ].obs;
  // final lockedCategories = [ "Dosham","Nakshatram"].obs;

  // 🔹 Selected options per category
  final selectedOptions = <String, List<String>>{}.obs;

  // 🔹 Change active category
  void changeCategory(int index) => selectedIndex.value = index;

  // 🔹 Check if category is locked
  bool isLocked(String category) => lockedCategories.contains(category);

  // 🔹 Toggle option selection
  void toggleOption(String category, String option) {
    final options = selectedOptions[category] ?? [];
    if (options.contains(option)) {
      options.remove(option);
    } else {
      options.add(option);
    }
    selectedOptions[category] = List.from(options); // important for Rx update
  }

  // 🔹 Check if an option is selected
  bool isOptionSelected(String category, String option) {
    return selectedOptions[category]?.contains(option) ?? false;
  }

  // 🔹 Reset all filters
  void resetFilters() => selectedOptions.clear();
}
