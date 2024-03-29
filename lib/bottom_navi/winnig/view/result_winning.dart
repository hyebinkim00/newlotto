import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/winnig/controller/winnig_controller.dart';

import '../../../ui/color_utils.dart';

class ResultWinning extends StatelessWidget {

  WinningController controller;
  ResultWinning({required this.controller});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 400.w,
        height: 150.h,
        margin: EdgeInsets.all(10),
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
        ),
        child: Obx(
              () =>
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${controller.resulSe} ', style: TextStyle(
                            color: Colors.deepOrange, fontSize: 20),),
                        Text(' 당첨결과', style: TextStyle(fontSize: 20),)
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
        ));
  }
}
