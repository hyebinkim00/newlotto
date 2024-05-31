import 'package:get/get.dart';
import 'package:newlotto/chart_content/charts/byPick/controller/byPickContoller.dart';

class byPickBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<byPickController>(() => byPickController());
  }
}