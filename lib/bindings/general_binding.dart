import '../utils/constants/path_provider.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NetworkManager(), fenix: true);
    // Get.lazyPut(() => AuthenticationRepository());
  }
}
