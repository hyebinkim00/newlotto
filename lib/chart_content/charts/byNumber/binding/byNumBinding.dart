import 'package:get/get.dart';

import '../controller/byNumChartController.dart';

class byNumBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NumChartController>(() => NumChartController());
  }
}