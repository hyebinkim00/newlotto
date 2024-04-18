import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:newlotto/ui/app_color.dart';

import '../../../config/route_names.dart';
import '../controller/chart_controller.dart';

class RecordPage extends StatelessWidget {
  // 당첨통계 차트들
  final List<String> cardText = [
    '번호별 통계',
    '색상통계',
    '연속번호통계',
    '확률로 보는 \n오늘의 번호'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<RecordController>(
      init: RecordController(),
      builder: (controller) {
        // 차트
        return SafeArea(
            top: true,
            child: Column(
              children: [
                Text(
                  '로또 6/25\n당첨통계',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // to disable GridView's scrolling
                  shrinkWrap: true,
                  // You won't see infinite size error
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.5, // 가로:세로 비율 설정
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        switch (index) {
                          case 0:
                            // 번호별 VerticalChart
                            Get.toNamed(RouteNames.NUMCHART);
                            break;
                          case 1:
                            // 색상 Pie
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => PieChartSample2()),
                            // );
                            Get.toNamed(RouteNames.COLORCHART);
                            break;
                          case 2:
                            // 연속번호
                            Get.toNamed(RouteNames.BIRTHDAY);
                            break;
                          case 3:
                            Get.toNamed(RouteNames.SPINNING);
                            break;
                        }
                        //
                        // await Future.delayed(Duration(seconds: 1)); // 1초간 기다립니다.
                        // FlutterLocalNotification.showNotification();
                      },
                      child: myMenu(index),
                    );
                  },
                  itemCount: cardText.length,
                )
                // 번호 별 통계
                // 구간별 통계
                // 연속 번호 통계 할까말까
              ],
            ));
      },
    ));
  }

  Widget myMenu(int index) {
    return Container(
      width: 30,
      height: 30,
      child: Card(
        color: AppColors.contentChart,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon(Icons.add_circle),
              Text('${cardText[index]}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            ]),
      ),
    );
  }
}
