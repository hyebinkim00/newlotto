import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/calendar/calendar_page.dart';
import 'package:newlotto/bottom_navi/home/view/home_page.dart';
import 'package:newlotto/bottom_navi/noti/noti_page.dart';
import 'package:newlotto/bottom_navi/winnig/view/winning_page.dart';
import '../../bottom_navi/mypage/view/mypage_page.dart';
import '../../bottom_navi/record/view/chart_page.dart';

class MainController extends GetxController{
  //static MainController get to => Get.find();

  RxInt currentIndex = 2.obs;

  List<Widget> pages = [
    RecordPage(),
    WinningPage(),
    HomePage(),
    NotiPage(),
    MyPage()
  ];

  Widget get currentPage => pages[currentIndex.value];

  void tabBar(int index){
    currentIndex.value = index;
  }
//    Get.find<MyPageController>().myData.value = "전달할 값";

}