import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:newlotto/bottom_navi/record/view/indicator.dart';
import 'package:newlotto/chart_content/charts/byColor/controller/byColorController.dart';

import '../../../../ui/app_color.dart';

class PieChartSample extends StatefulWidget {
 final byColorController controller;
  PieChartSample(this.controller);

  @override
  State<StatefulWidget> createState() => _PieChart2State();
}

class _PieChart2State extends State<PieChartSample> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Obx(()=>
                  PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.black, width: 2), // 테두리 스타일 설정
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: 40,
                      sections: showingSections(widget.controller.pielist),
                    ),
                  )),
            ),
          ),

          //     1번부터 10번까지는 노란색입니다.
          // 11번 부터 20번까지는 파란색입니다.
          // 21번부터 30번까지는 빨간색입니다.
          // 31번부터 40번까지는 검은색입니다.
          // 41번부터 45번까지는 초록색입니다.
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: AppColors.contentColorYellow,
                text: '1~10',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorBlue,
                text: '11~20',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorRed,
                text: '21~30',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorBlack,
                text: '31~40',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.green,
                text: '41~45',
                isSquare: true,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }


  //     1번부터 10번까지는 노란색입니다.
  // 11번 부터 20번까지는 파란색입니다.
  // 21번부터 30번까지는 빨간색입니다.
  // 31번부터 40번까지는 검은색입니다.
  // 41번부터 45번까지는 초록색입니다.

  List<PieChartSectionData> showingSections(RxList sectionList) {
    final List<Color> colors = [
      Colors.yellow,
      Colors.blue,
      Colors.pink,
      Colors.grey,
      Colors.green,
    ];
    return List.generate(sectionList.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.blue, blurRadius: 2)];
      return PieChartSectionData(
        color: colors[i],
        value: 20,
        title: '${sectionList[i]}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );

      // switch (i) {
      //   case 0:
      //     return PieChartSectionData(
      //       color: AppColors.contentColorBlue,
      //       value: 40,
      //       title: '40%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.mainTextColor1,
      //         shadows: shadows,
      //       ),
      //     );
      //   case 1:
      //     return PieChartSectionData(
      //       color: AppColors.contentColorYellow,
      //       value: 30,
      //       title: '30%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.mainTextColor1,
      //         shadows: shadows,
      //       ),
      //     );
      //   case 2:
      //     return PieChartSectionData(
      //       color: AppColors.contentColorPurple,
      //       value: 15,
      //       title: '15%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.mainTextColor1,
      //         shadows: shadows,
      //       ),
      //     );
      //   case 3:
      //     return PieChartSectionData(
      //       color: AppColors.contentColorGreen,
      //       value: 15,
      //       title: '15%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //         fontSize: fontSize,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.mainTextColor1,
      //         shadows: shadows,
      //       ),
      //     );
      //   default:
      //     throw Error();
      // }
    });
  }
}