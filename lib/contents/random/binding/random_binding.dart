import 'package:get/get.dart';

import '../controller/random_controller.dart';

class RandomBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RandomController>(RandomController(), permanent: true);

    }
}