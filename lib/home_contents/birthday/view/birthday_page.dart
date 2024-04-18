import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/birthday_controller.dart';

class BirthDayPage extends GetView<BirthDayController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Text('생일로 보는 오늘의 숫자'),
                // 생일이랑 오늘 날짜를 계산해서 생일마다 하루동안은 같은수
                TextField(
                    controller: controller.textEdit,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "클릭하여 생일을 입력해주세요!" //label text of field
                        ),
                    readOnly: true,
                    // when true user cannot edit text
                    onTap: () async {
                      controller.showDatePickerPop(context);
                      //when click we have to show the datepicker
                    }),
                TextButton(onPressed: () {
                  controller.generateTodayNumber();
                }, child: Text('내 행분의 번호 조회!!')),
                Obx(() => Text('${controller.luckyNum}'))

                // Obx(() => GestureDetector(
                //       onTap: () {
                //       },
                //       child: AnimatedContainer(
                //         duration: Duration(milliseconds: 500),
                //         curve: Curves.easeInOut,
                //         transform: Matrix4.rotationY(
                //             controller.angle.value * (3.1415927 / 180)),
                //         width: 100,
                //         height: 100,
                //         decoration: BoxDecoration(
                //           color: controller.backgroundColor.value,
                //           shape: BoxShape.circle,
                //         ),
                //         child: Center(
                //           child: Text(
                //             controller.isBack.value ? '' : '${controller.luckyNum}',
                //             style: TextStyle(color: Colors.black),
                //           ),
                //         ),
                //       ),
                //     ))
              ],
            ),
          )),
    );
  }
}
