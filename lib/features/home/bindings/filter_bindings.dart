import 'package:tamilnadu_matrimony/features/home/controller/filter_controller.dart';

import '../../../utils/constants/path_provider.dart';

class FilterBindings extends Bindings{
  @override
  void dependencies() {
Get.lazyPut(()=>FilterController());
  }

}