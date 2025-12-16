import 'package:tamilnadu_matrimony/features/profile/repository/profile_repository.dart';

import '../features/home/controller/filter_controller.dart';
import '../utils/constants/path_provider.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.put( FilterController(), permanent: true);
    Get.lazyPut(() => ProfileRepository());
  }
}
