import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/controller/noti_controller.dart';
import 'package:newlotto/bottom_navi/winnig/controller/winnig_controller.dart';
import 'package:newlotto/bottom_navi/winnig/view/result_winning.dart';
import 'package:newlotto/bottom_navi/winnig/view/search_winning.dart';
import 'package:newlotto/bottom_navi/winnig/view/table_winnig.dart';


class WinningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: GetBuilder<WinningController>(
      init: WinningController(),
      builder: (controller) {
        // API로 가져오기
        return SafeArea(
            top: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '회차 별 당첨금',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SearchWinning(controller: controller),
                ResultWinning(controller: controller),
                TableWinning(controller: controller)

              ],
            ));
      },
    ));
  }
}
