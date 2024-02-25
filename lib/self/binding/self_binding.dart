import 'package:get/get.dart';

import '../controller/self_controller.dart';

class SelfBinding extends Bindings{
  @override
  void dependencies() {
     Get.lazyPut<SelfController>(() => SelfController());
  }

}