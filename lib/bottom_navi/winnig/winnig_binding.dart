import 'package:get/get.dart';

import 'winnig_controller.dart';

class WinningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WinningController());
  }

}