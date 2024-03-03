import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/calendar/calendar_controller.dart';

class CalendarBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CalendarController());
  }

}