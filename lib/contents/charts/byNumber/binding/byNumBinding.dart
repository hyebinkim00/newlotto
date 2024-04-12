import 'package:get/get.dart';
import 'package:newlotto/contents/charts/byNumber/controller/byNumChartController.dart';

class byNumBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NumChartController>(() => NumChartController());
  }
}