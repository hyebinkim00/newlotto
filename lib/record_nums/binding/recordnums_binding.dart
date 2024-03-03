import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/recordnums_controller.dart';

class RecordNumsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RecordNumsController>(() => RecordNumsController());
  }
}