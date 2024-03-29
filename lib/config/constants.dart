import 'package:get/get.dart';
import 'package:newlotto/config/route_names.dart';
import 'package:newlotto/main/binding/main_binding.dart';
import 'package:newlotto/self/view/self_page.dart';
import '../main/view/main_page.dart';
import '../qrscan/binding/qrscan_binding.dart';
import '../qrscan/view/qrscan_page.dart';
import '../random2/binding/random2_binding.dart';
import '../random2/view/random2_page.dart';
import '../self/binding/self_binding.dart';
import '../spinning/circlespin_binding.dart';
import '../spinning/circlespin_page.dart';

class Constants {
  static final List<GetPage> APP_PAGES = [
    GetPage(
      name: RouteNames.MAIN,
      page: () => MainPage(),
      binding: MainBinding()
    ),
    GetPage(
      name: RouteNames.RANDOM,
      page: () => Random2Page(),
      binding: Random2Binding(),
    ),
    GetPage(
      name: RouteNames.SELF,
      page: () => SelfPage(),
      binding: SelfBinding(),
    ),
    GetPage(
      name: RouteNames.QRSACN,
      page: () => QrscanPage(),
      binding: QrscanBinding(),
    ),

    GetPage(
      name: RouteNames.SPINNING,
      page: () => CircleSpinPage(),
      binding: CircleSpinBinding(),
    )

  ];


}
