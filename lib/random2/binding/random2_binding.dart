import 'package:get/get.dart';

import '../controller/random2_controller.dart';

class Random2Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<Random2Controller>(() => Random2Controller());
  }

}