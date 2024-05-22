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
          label: "번호${controller.nums[index]}",
          jumlah: int.parse(controller.percent[index])/10.w ,
          tooltip: "${controller.percent[index]} 회",
          colors: [Colors.orange, Colors.deepOrange],
        );
      });

      // Text 크기가 변경 불가
      return InteractiveViewer(
        child: SingleChildScrollView(
          child: VerticalBarchart(
            barSize: 30.h,
            maxX: 30.w,
            data: bardata2,
            showLegend: true,
            showBackdrop: true,
            barStyle: BarStyle.CIRCLE,
            alwaysShowDescription: true,
            labelSizeFactor: 0.2,
            // tooltipSize:50,
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
