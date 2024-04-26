import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/birthday_controller.dart';

class BirthDayPage extends GetView<BirthDayController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // 그림자를 제거
        centerTitle: true,
        title: Text(
          '내 생일로 보는 오늘의 번호',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            color: Colors.black,
            // 아이콘의 색상을 검정색으로 설정
            onPressed: () {
              Get.back();
            }),
      ),      body: SafeArea(
          top: true,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Text('오늘의 번호'),
                // 생일이랑 오늘 날짜를 계산해서 생일마다 하루동안은 같은수
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: TextField(
                      controller: controller.textEdit,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "클릭하여 생일을 입력해주세요!"
                          ),
                      readOnly: true,
                      // when true user cannot edit text
                      onTap: () async {
                        controller.showDatePickerPop(context);
                        //when click we have to show the datepicker
                      }),
                ),
                TextButton(onPressed: () {
                  controller.generateTodayNumber();
                }, child: Text('내 행분의 번호 조회!!')),

                Obx(() => GestureDetector(
                      onTap: () {
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        transform: Matrix4.rotationY(
                            controller.angle.value * (3.1415927 / 180)),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: controller.backgroundColor.value,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            controller.isBack.value ? '' : '${controller.luckyNum}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
