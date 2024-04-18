import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../ui/color_utils.dart';
import '../controller/recentanalysis_controller.dart';

class RecentAnalysisPage extends GetView<RecentAnalysisController> {
  //가장 많이 나온 숫자: 이전 로또 추첨 결과를 분석하여 가장 자주 나온 숫자들을 확인하는 것은 많은 사람들이 관심을 가지는 주제입니다. 특정 숫자가 자주 나온다는 사실은 해당 숫자를 선택하는 데 도움이 될 수 있다고 여겨질 수 있습니다.
  //
  // 가장 적게 나온 숫자: 반대로, 이전 추첨 결과에서 가장 적게 나온 숫자들을 확인하는 것도 중요합니다. 어떤 숫자가 오랫동안 나오지 않았다면 다음 번 추첨에서 나올 가능성이 높다고 여겨질 수 있습니다.
  //
  // 숫자의 연속성: 인접한 추첨 결과에서 숫자들 사이의 연속성을 분석하는 것도 중요합니다. 예를 들어, 최근에 1, 2, 3, 4, 5, 6과 같은 연속된 숫자가 나온다면 다음 추첨 결과에서는 이러한 패턴이 계속될지 여부에 대해 궁금증이 생길 수 있습니다.
  //
  // 짝수와 홀수 숫자의 분포: 추첨 결과에서 짝수와 홀수 숫자의 비율을 분석하는 것도 중요합니다. 예를 들어, 최근 추첨 결과에서 홀수 숫자가 더 많이 나왔다면 다음 추첨에서는 짝수 숫자가 나올 가능성이 높다고 여겨질 수 있습니다.
  //
  // 패턴 및 반복: 이전 추첨 결과에서 특정한 숫자 패턴이나 반복되는 숫자들을 확인하는 것도 중요합니다. 예를 들어, 특정한 숫자가 연속해서 나오거나 두 번 이상 나온 경우에는 해당 숫자를 선택하는 데 대한 고려가 필요합니다.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [

                Row(children: [
                  Text('가장 많이 나온 숫자'),
                  Obx(() => Text('${controller.mostNum}'+'('+'${controller.mostNumf}'+')'))
                ],),
                Row(children: [
                  Text('가장 적게 나온 숫자'),
                  Obx(() => Text('${controller.LeastNum}'+'('+'${controller.leastNumf}'+')'))
                ],),

                Obx(
                  () => Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(4),
                    },
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          TableCell(child: Center(child: Text('추첨일'))),
                          TableCell(child: Center(child: Text('당첨번호'))),
                        ],
                      ),
                      ...List.generate(
                        controller.list.length,
                        (index) => TableRow(
                          children: [
                            TableCell(
                                child: Container(
                                  height:50.h,
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
                                      width: 250.w,
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(
                                          7,
                                          (indexs) {
                                            return Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorUtil.getColors(
                                                      controller.list[index]
                                                          .getLists()[indexs]
                                                          .toString()),
                                                ),
                                                child: Container(
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text(
                                                        '${controller.list[index].getLists()[indexs]}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          // 텍스트 색상 설정
                                                          fontSize:
                                                              15.0, // 텍스트 크기 설정
                                                        ),
                                                      ),
                                                    )),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
