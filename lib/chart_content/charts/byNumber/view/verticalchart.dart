import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

import '../controller/byNumChartController.dart';

class VerticalChart extends StatelessWidget {
  NumChartController controller;
  VerticalChart({required this.controller});

  ///https://www.dhlottery.co.kr/gameResult.do?method=statByNumber&sttDrwNo=14&edDrwNo=1114
// srchType (기본값 list -> 번호순 , dir -> 당첨횟수 순

// + 날짜 선택기
// + 최근 10회차 기준으로 확인

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<VBarChartModel> bardata2 = List.generate(controller.nums.length, (index) {
        return VBarChartModel(
          index: index,
          label: "${controller.nums[index]}",
          jumlah: int.parse(controller.percent[index]).w ,
          tooltip: "${controller.percent[index]} 회",
          colors: [Colors.orange, Colors.deepOrange],
        );
      });

      return SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: 500.w,
          child: VerticalBarchart(
            barSize: 50.h,
            maxX: 300.w,
            data: bardata2,
            showLegend: true,
            showBackdrop: true,
            barStyle: BarStyle.DEFAULT,
            alwaysShowDescription: true,
            labelSizeFactor: 0.1,
            tooltipSize:50,
            legend: [
              Vlegend(
                isSquare: true,
                color: Colors.orange,
                text: "Fruits",
              ),
            ],
          ),
        ),
      );
    });
  }
}
