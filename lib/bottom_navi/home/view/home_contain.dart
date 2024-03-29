import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/home/controller/home_controller.dart';

import '../../../config/route_names.dart';
import '../../../ui/color_utils.dart';

class HomeContainer extends StatelessWidget {
  late HomeController controller;

  HomeContainer({required this.controller});

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
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorUtil.getColors(controller.lists[index]),
                          ),
                          child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                '${controller.lists[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
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
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                ),
                onPressed: () {
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
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
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
