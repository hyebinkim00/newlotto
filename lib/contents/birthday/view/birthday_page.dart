
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

                Text('생일을 입력해주세요.!'),
                // 생일이랑 오늘 날짜를 계산해서 생일마다 하루동안은 같은수
                TextField(
                    controller: controller.textEdit,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly: true,
                    // when true user cannot edit text
                    onTap: () async {
                      controller.showSpin(context);
                      //when click we have to show the datepicker
                    }),
              ],
            ),
          )),
    );
  }
}
