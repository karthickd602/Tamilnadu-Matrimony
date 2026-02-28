import 'package:tamilnadu_matrimony/features/profile/repository/profile_repository.dart';

import '../utils/constants/path_provider.dart';
import '../data/services/dynamic_link_service.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    // final storage = GetStorage();
    // await storage.write(TTexts.userId,"11623");

    // Dependencies
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => ProfileRepository());
    Get.put(DynamicLinkService());

    // Get.put( FilterController(), permanent: true);
  }
}
