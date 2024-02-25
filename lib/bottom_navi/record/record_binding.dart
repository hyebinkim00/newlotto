import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/record/record_controller.dart';

class RecordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RecordController());
  }

}