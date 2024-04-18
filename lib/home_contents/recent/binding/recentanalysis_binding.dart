import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:newlotto/home_contents/recent/controller/recentanalysis_controller.dart';

class RecentAnalysisBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RecentAnalysisController>(RecentAnalysisController());
  }

}