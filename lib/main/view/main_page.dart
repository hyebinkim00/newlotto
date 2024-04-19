import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:newlotto/main/controller/main_controller.dart';

class MainPage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() => controller.currentPage)),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex.value,
            onTap: (value) => {controller.tabBar(value)},
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white24,
            backgroundColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded),
                label: '당첨번호\n통계',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: '회차별\n당첨금',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_mark),
                label: '사용법',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                label: '마이페이지',
              ),
            ],
          )),
    );
  }
}
