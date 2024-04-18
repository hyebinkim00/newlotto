import 'package:get/get.dart';
import 'package:newlotto/config/route_names.dart';
import 'package:newlotto/home_contents/recent/binding/recentanalysis_binding.dart';
import 'package:newlotto/home_contents/recent/view/recnet_page.dart';

import 'package:newlotto/main/binding/main_binding.dart';
import 'package:newlotto/self/view/self_page.dart';

import '../chart_content/charts/byColor/binding/byColorBinding.dart';
import '../chart_content/charts/byColor/view/byColorChartPage.dart';
import '../chart_content/charts/byNumber/binding/byNumBinding.dart';
import '../chart_content/charts/byNumber/view/byNumChartPage.dart';
import '../home_contents/birthday/binding/birthday_binding.dart';
import '../home_contents/birthday/view/birthday_page.dart';
import '../home_contents/random/binding/random_binding.dart';
import '../home_contents/random/view/random_page.dart';
import '../home_contents/spinning/circlespin_binding.dart';
import '../home_contents/spinning/circlespin_page.dart';
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

    // 구매번호 입력 2개
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

    // 홈 - 번호 추천 콘텐츠 4개
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
      name: RouteNames.RECENT,
      page: () => RecentAnalysisPage(),
      binding: RecentAnalysisBinding(),
    ),

    // 차트 페이지 - 차트 콘텐츠
    GetPage(
      name: RouteNames.NUMCHART,
      page: () => ByNumChartPage(),
      binding: byNumBinding(),
    ),
    GetPage(
      name: RouteNames.COLORCHART,
      page: () => ByColorChartPage(),
      binding: byColorBinding(),
    ),
  ];
}
