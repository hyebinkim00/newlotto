import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/home_contents/recent/controller/recentanalysis_controller.dart';

import '../../../ui/color_utils.dart';

class PatternTable extends StatelessWidget {
  RecentAnalysisController controller;

  PatternTable(this.controller);

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
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(4),
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
                            height: 50.h, child: Center(child: Text('당첨번호')))),
                  ],
                ),
                ...List.generate(
                  controller.list.length,
                  (index) => TableRow(
                    children: [
                      TableCell(
                          child: Container(
                              height: 70.h,
                              width: 50.w,
                              child: Center(
                                  child: Text(
                                      '${controller.list[index].drwNoDate}')))),
                      TableCell(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                height: 70.h,
                                width: 250.w,
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: List.generate(
                                    7,
                                    (indexs) {
                                      // 다음 숫자 값
                                      final nextValue =
                                          controller.list[index].getLists()[
                                              (indexs + 1) %
                                                  controller.list[index]
                                                      .getLists()
                                                      .length];

                                      // 현재 숫자 값
                                      final currentValue = controller
                                          .list[index]
                                          .getLists()[indexs];

                                      // 이전 숫자 값
                                      final previousValue = (indexs == 0)
                                          ? 100
                                          : controller.list[index]
                                              .getLists()[indexs - 1];

                                      bool condition =
                                          currentValue + 1 == nextValue ||
                                              previousValue + 1 == currentValue;
                                      return Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: condition
                                                ? Border(
                                                    bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 2,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          child: Container(
                                            // padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 1,
                                                    color: ColorUtil.getColors(
                                                        controller.list[index]
                                                            .getLists()[indexs]
                                                            .toString()))),
                                            child: Container(
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    '${controller.list[index].getLists()[indexs]}',
                                                    style: TextStyle(
                                                      color:
                                                          ColorUtil.getColors(
                                                              controller
                                                                  .list[index]
                                                                  .getLists()[
                                                                      indexs]
                                                                  .toString()),
                                                      shadows: [
                                                        Shadow(
                                                          color: ColorUtil
                                                              .getColors(controller
                                                                  .list[index]
                                                                  .getLists()[
                                                                      indexs]
                                                                  .toString()),
                                                          offset: Offset(0, 1),
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                      // 텍스트 색상 설정
                                                      fontSize:
                                                          15.0, // 텍스트 크기 설정
                                                    ),
                                                  ),
                                                )),
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
