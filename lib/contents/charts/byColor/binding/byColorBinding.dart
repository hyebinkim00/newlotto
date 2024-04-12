import 'package:get/get.dart';
import 'package:newlotto/contents/charts/byColor/controller/byColorController.dart';

class byNumBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<byColorController>(() => byColorController());
  }
}