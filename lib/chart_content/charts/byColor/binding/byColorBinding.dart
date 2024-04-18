import 'package:get/get.dart';
import '../controller/byColorController.dart';

class byColorBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<byColorController>(() => byColorController());
  }
}