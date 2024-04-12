import 'package:get/get.dart';
import 'package:newlotto/config/route_names.dart';
import 'package:newlotto/contents/birthday/binding/birthday_binding.dart';
import 'package:newlotto/contents/birthday/view/birthday_page.dart';
import 'package:newlotto/contents/charts/byColor/view/byColorChartPage.dart';
import 'package:newlotto/contents/charts/byNumber/controller/byNumChartController.dart';
import 'package:newlotto/contents/charts/byNumber/view/byNumChartPage.dart';
import 'package:newlotto/main/binding/main_binding.dart';
import 'package:newlotto/self/view/self_page.dart';

import '../contents/charts/byNumber/binding/byNumBinding.dart';
import '../contents/random/binding/random_binding.dart';
import '../contents/random/view/random_page.dart';
import '../contents/spinning/circlespin_binding.dart';
import '../contents/spinning/circlespin_page.dart';
import '../main/view/main_page.dart';
import '../qrscan/binding/qrscan_binding.dart';
import '../qrscan/view/qrscan_page.dart';

import '../self/binding/self_binding.dart';


class Constants {
  static final List<GetPage> APP_PAGES = [
    GetPage(
      name: RouteNames.MAIN,
      page: () => MainPage(),
      binding: MainBinding()
    ),

    // 구매번호 2개
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

    // 번호 추천 콘텐츠
    GetPage(
      name: RouteNames.RANDOM,
      page: () => RandomPage(),
      binding: RandomBinding(),
    ),
    GetPage(
      name: RouteNames.SPINNING,
      page: () => CircleSpinPage(),
      binding: CircleSpinBinding(),
    ),
    GetPage(
      name: RouteNames.BIRTHDAY,
      page: () => BirthDayPage(),
      binding: BirthdayBinding(),
    ),
    GetPage(
      name: RouteNames.NUMCHART,
      page: () => ByNumChartPage(),
      binding: byNumBinding(),
    ),
    GetPage(
      name: RouteNames.COLORCHART,
      page: () => ByColorChartPage(),
      binding: byNumBinding(),
    ),
  ];
}
