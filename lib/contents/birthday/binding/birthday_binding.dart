

import 'package:get/get.dart';

import '../controller/birthday_controller.dart';

class BirthdayBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(BirthDayController());
  }
}