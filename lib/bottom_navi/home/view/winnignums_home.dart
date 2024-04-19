import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/home/controller/home_controller.dart';

import '../../../config/route_names.dart';
import '../../../ui/color_utils.dart';

class WinningNums extends StatelessWidget {
  late HomeController controller;

  WinningNums({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 300,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 오늘 날짜
        Column(
          children: [
            Obx(() => Text('${controller.todays}',
              style: TextStyle(fontSize: 17),
            )),
            SizedBox(height: 10,),
            // 최신회차 당첨 번
            Obx(
                  () => Text(
                '${controller.lastSerial.value} 회 당첨 번호',
                // .value를 사용하여 GetX 컨트롤러의 값에 직접 접근
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
          Obx(() => Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    8,
                        (index) {
                      return Expanded(
                        flex: 1,
                        child: Container(
                          width: 50, // 고정된 너비
                          height: 50, // 고정된 높이
                          padding: EdgeInsets.all(1),
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtil.getColors(controller.lists[index]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '${controller.lists[index]}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                ),
                onPressed: () {
                  Get.toNamed(RouteNames.SELF);
                  // Get.toNamed(RouteNames.SELF,
                  //     arguments: {'lastSerial': controller.lastSerial.value});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.confirmation_number_outlined),
                    Text(' 번호로 직접입력',)
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(RouteNames.QRSACN);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.camera_alt_outlined),
                    Text(' QR코드로 스캔')
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
