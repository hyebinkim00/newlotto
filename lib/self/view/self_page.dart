import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/main/controller/main_controller.dart';

import '../../config/route_names.dart';
import '../../ui/dialog_utils.dart';
import '../controller/self_controller.dart';

class SelfPage extends GetView<SelfController> {
  @override
  Widget build(BuildContext context) {
    // Get.toNamed argument 로 바꿈
    return Scaffold(
      body: SafeArea(
          top: true,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.orangeAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            '제 ${controller.btnText}회',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                      OutlinedButton(
                          onPressed: () {
                            DialogUtils.selectSerial(context, controller);
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                width: 2, color: Colors.white), // 테두리 설정
                          ),
                          child: Text('회차 변경',style: TextStyle(color: Colors.white),))
                    ],
                  ),
                ),
                 Container(
                  margin: EdgeInsets.only(left: 10,top: 15,bottom: 15),
                 height: 550,
                 //  height: MediaQuery.of(context).size.height*0.8,
                    width: 500,
                    child : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return controller.items(index);
                      },
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {

                        // 2024 02 29
                        // 테스트 하려고 여기다 넣은거지 Qr 처럼 다이어로그 거기서 저장누르면 저장
                        controller.save();
                      },
                      child: Text('확인하기'),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }



}
