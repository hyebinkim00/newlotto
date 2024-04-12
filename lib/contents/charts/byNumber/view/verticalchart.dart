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
          alignment: Alignment.topLeft,
          width: 300.w,
          child: VerticalBarchart(
            maxX: 500.w,
            data: bardata2,
            showLegend: true,
            showBackdrop: true,
            barStyle: BarStyle.DEFAULT,
            alwaysShowDescription: true,
            legend: [
              Vlegend(
                isSquare: true,
                color: Colors.orange,
                text: "Fruits",
              ),
              Vlegend(
                isSquare: false,
                color: Colors.teal,
                text: "Vegetables",
              )
            ],
          ),
        ),
      );
    });
  }
}
