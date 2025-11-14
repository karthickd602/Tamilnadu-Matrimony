import 'package:tamilnadu_matrimony/utils/constants/api_constants.dart';
import 'package:tamilnadu_matrimony/utils/http/http_client.dart';

import '../../../utils/constants/path_provider.dart';
import '../model/dashboard_list_model.dart';

class DashboardController extends GetxController {
  var customerList = <Map<String, dynamic>>[].obs;

  final RxBool isLoading = true.obs;
  final dashboardCustomerList = <CustomerProfileListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProfiles();
    fetchDashboardCustomerProfile();
  }

  Future<void> fetchDashboardCustomerProfile() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "Error",
          message: "No Internet Connection",
        );
        return;
      }
      isLoading.value = true;
      final req = {"id": TTexts.userId};
      final response = await THttpHelper.post(
        ApiConstant.dashboardListEndPoint,
        req,
      );

      debugPrint("response: $response");

      dashboardCustomerList.value = (response["profiles"] as List)
          .map((e) => CustomerProfileListModel.fromJson(e))
          .toList();

      isLoading.value =false;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  void loadProfiles() {
    customerList.value = [
      {
        "name": "Karthick",
        "age": 27,
        "marital": "Never Married",
        "religion": "Muslim",
        "caste": "Lebbai",
        "job": "Software Engineer",
        "qualification": "B.E. CSE",
        "height": "5 ft 8 in",
        "location": "Madurai",
        "image": TImages.sampleUser,
      },
      {
        "name": "Priya",
        "age": 25,
        "marital": "Never Married",
        "religion": "Hindu",
        "caste": "Iyer",
        "job": "Doctor",
        "qualification": "MBBS",
        "height": "5 ft 4 in",
        "location": "Chennai",
        "image": TImages.sampleUser,
      },
      {
        "name": "Arjun",
        "age": 30,
        "marital": "Never Married",
        "religion": "Hindu",
        "caste": "Nair",
        "job": "Civil Engineer",
        "qualification": "B.Tech",
        "height": "5 ft 10 in",
        "location": "Bangalore",
        "image": TImages.sampleUser,
      },
      {
        "name": "Sneha",
        "age": 28,
        "marital": "Never Married",
        "religion": "Christian",
        "caste": "Syrian Christian",
        "job": "Teacher",
        "qualification": "M.Sc",
        "height": "5 ft 5 in",
        "location": "Kochi",
        "image": TImages.sampleUser,
      },
      {
        "name": "Vikram",
        "age": 32,
        "marital": "Divorced",
        "religion": "Hindu",
        "caste": "Reddy",
        "job": "Businessman",
        "qualification": "MBA",
        "height": "6 ft 0 in",
        "location": "Hyderabad",
        "image": TImages.sampleUser,
      },
      {
        "name": "Ananya",
        "age": 26,
        "marital": "Never Married",
        "religion": "Hindu",
        "caste": "Brahmin",
        "job": "Software Developer",
        "qualification": "B.Tech",
        "height": "5 ft 3 in",
        "location": "Pune",
        "image": TImages.sampleUser,
      },
      {
        "name": "Rahul",
        "age": 29,
        "marital": "Never Married",
        "religion": "Muslim",
        "caste": "Qureshi",
        "job": "Data Scientist",
        "qualification": "M.Tech",
        "height": "5 ft 9 in",
        "location": "Delhi",
        "image": TImages.sampleUser,
      },
      {
        "name": "Meera",
        "age": 27,
        "marital": "Never Married",
        "religion": "Hindu",
        "caste": "Gupta",
        "job": "Lawyer",
        "qualification": "LLB",
        "height": "5 ft 6 in",
        "location": "Mumbai",
        "image": TImages.sampleUser,
      },
    ];
  }

  void onLike(String name) {
    Get.snackbar("Liked", "You liked $name ❤️");
  }

  void onSkip(String name) {
    Get.snackbar("Skipped", "You skipped $name ❌");
  }

  void onSuperLike(String name) {
    Get.snackbar("Superliked", "You superliked $name ⭐");
  }
}
