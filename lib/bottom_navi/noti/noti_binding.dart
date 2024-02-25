import 'package:get/get.dart';

import 'noti_controller.dart';

class NotiBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NotiController());
  }

}