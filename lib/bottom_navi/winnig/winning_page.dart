import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/noti_controller.dart';
import 'package:newlotto/bottom_navi/winnig/winnig_controller.dart';

import '../../ui/color_utils.dart';

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
                // 회차
                // Row(
                //   children: [
                //     Icon(Icons)
                //   ],
                // ),,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                        menuMaxHeight: 400,
                        hint: Obx(
                          () => Text('${controller.serial}'),
                        ),
                        items: controller
                            .items
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          controller.changeValue(value!);
                        }),
                    Text('회'),
                    SizedBox(width: 10,),
                    TextButton(style : ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                        onPressed: () {controller.getWebResult(controller.serial.value);},
                        child: Text('조회', style: TextStyle(color: Colors.white),))
                  ],
                ),
                Container(
                    width: 400.w,
                    height: 150.h,
                    margin: EdgeInsets.all(10),
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26),
                    ),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${controller.resulSe} ' ,style: TextStyle(color: Colors.deepOrange, fontSize: 20),),
                                Text(' 당첨결과',style: TextStyle( fontSize: 20),)
                              ]),
                          Text('${controller.dated}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 300.w,
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: List.generate(
                                        6,
                                        (index) {
                                          return Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorUtil.getColors(
                                                    controller.Numbers[index]),
                                              ),
                                              child: Container(
                                                  width: double.infinity,
                                                  child: Center(
                                                    child: Text(
                                                      '${controller.Numbers[index]}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        // 텍스트 색상 설정
                                                        fontSize:
                                                            20.0, // 텍스트 크기 설정
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Text('+'),
                                  Container(
                                    width: 60.w,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorUtil.getColors(
                                          controller.bonusNum.value),
                                    ),
                                    child: Container(
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            '${controller.bonusNum.value}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              // 텍스트 색상 설정
                                              fontSize: 20.0, // 텍스트 크기 설정
                                            ),
                                          ),
                                        )),
                                  ), // 왼쪽 간격
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                Obx(() => DataTable(
                      columns: [
                        DataColumn(label: Expanded(child: Text('순위'))),
                        DataColumn(label: Expanded(child: Text('당첨게임 수'))),
                        DataColumn(label: Expanded(child: Text('1게임당 당첨금액'))),
                      ],
                      rows: List<DataRow>.generate(
                        controller.inlist2.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text('${index + 1}등')),
                            DataCell(
                                Text('${controller.inlist2[index].people}')),
                            DataCell(
                                Text('${controller.inlist2[index].money}')),
                          ],
                        ),
                      ),
                    )),
              ],
            ));
      },
    ));
  }
}
