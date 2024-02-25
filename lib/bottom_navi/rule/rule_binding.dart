import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/rule/rule_controller.dart';

class RuleBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RuleController());
  }

}