import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:newlotto/home_contents/recent/controller/recentanalysis_controller.dart';

import '../../../ui/color_utils.dart';

class OddEvenTable extends StatelessWidget {
  RecentAnalysisController controller;

  OddEvenTable(this.controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(
          () => Container(
            decoration: BoxDecoration(color: Colors.grey),
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(4),
              },
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                        child: Container(
                            height: 50.h, child: Center(child: Text('추첨일')))),
                    TableCell(
                        child: Container(
                            height: 50.h, child: Center(child: Text('홀수')))),
                    TableCell(
                        child: Container(
                            height: 50.h, child: Center(child: Text('짝수')))),
                  ],
                ),
                ...List.generate(
                  controller.list.length,
                  (index) => TableRow(
                    children: [
                      TableCell(
                          child: Container(
                              height: 50.h,
                              width: 50.w,
                              child: Center(
                                  child: Text(
                                      '${controller.list[index].drwNoDate}')))),
                      // TableCell 추가 해서 홀수 리스트
                      TableCell(
                          //  홀수 리스트
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                width: 150.w,
                                padding: EdgeInsets.all(5),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: 5.0, // 각 줄 사이의 수직 간격
                                  children: List.generate(
                                    controller.oddList[index].length,
                                    (indexs) {
                                      return Container(
                                        width: 40.0, // 필요에 따라 너비 조정
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorUtil.getColors(
                                              controller.oddList[index]
                                                      [indexs]
                                                  .toString()),
                                        ),
                                        child: Container(
                                            width: double.infinity,
                                            child: Center(
                                              child: Text(
                                                '${controller.oddList[index][indexs]}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  // 텍스트 색상 설정
                                                  fontSize:
                                                      15.0, // 텍스트 크기 설정
                                                ),
                                              ),
                                            )),
                                      );
                                    },
                                  ),
                                ),
                              ), // 왼쪽 간격
                            ],
                          )
                        ],
                      )),
                      TableCell(
                          // 짝수 리스트로 바꿔야됨
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                width: 150.w,
                                padding: EdgeInsets.all(5),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: 5.0, // 각 줄 사이의 수직 간격
                                  // spacing: 5.0, // 항목들 간의 수평 간격
                                  children: List.generate(
                                    controller.evenList[index].length,
                                    (indexs) {
                                      return Container(
                                        width: 40.0, // 필요에 따라 너비 조정
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorUtil.getColors(controller
                                              .evenList[index][indexs]
                                              .toString()),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(
                                              '${controller.evenList[index][indexs]}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ), // 왼쪽 간격
                            ],
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
