import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:newlotto/ui/app_color.dart';

import '../../../config/route_names.dart';
import '../controller/chart_controller.dart';

class RecordPage extends StatelessWidget {
  // 당첨통계 차트들
  final List<String> cardText = ['번호별 통계', '색상별 통계', '연속번호 통계', '숫자합계 통계'];

  List<IconData> iconDataList = [
    Icons.stacked_line_chart,
    Icons.pie_chart,
    Icons.pattern,
    Icons.add,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // 그림자를 제거
          centerTitle: true,
          title: Text(
            '당첨번호에 대한 통계',
            style: TextStyle(color: Colors.black),
          ),

        ),
        body: GetBuilder<RecordController>(
          init: RecordController(),
          builder: (controller) {
            // 차트
            return SafeArea(
                top: true,
                child: Column(
                  children: [
                    Container(
                      height: 150.h,
                      margin: EdgeInsets.only(left: 5,right: 5,top: 10 ,bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.insert_chart_outlined_rounded,
                            color: Colors.white,
                            size: 70,
                          ),
                          Text('다양한 방법으로 확률을 알아보세요!',style: TextStyle(color: Colors.white),)
                        ],
                      ),
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
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(iconDataList[index]),
              Text('${cardText[index]}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ]),
      ),
    );
  }
}
