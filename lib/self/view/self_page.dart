import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/main/controller/main_controller.dart';
import 'package:newlotto/self/view/input_self.dart';
import 'package:newlotto/self/view/serial_self.dart';

import '../../config/route_names.dart';
import '../../ui/dialog_utils.dart';
import '../controller/self_controller.dart';

class SelfPage extends GetView<SelfController> {
  @override
  Widget build(BuildContext context) {
    // Get.toNamed argument 로 바꿈
    // IOS 뒤로 가기 추가해야됨 https://zoiworld.tistory.com/771

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('직접 입력', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: () {Get.back();}),
      ),
      body: SafeArea(
          top: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SerialSelection(controller: controller),
              InputList(controller: controller),
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
          )),
    );
  }
}
