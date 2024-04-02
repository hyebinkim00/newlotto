import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/birthday_controller.dart';

class BirthDayPage extends GetView<BirthDayController> {

  late TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top:  true,
        child: Column(
          children: [
            // TextField(
            //     controller: dateController, //editing controller of this TextField
            //     decoration: const InputDecoration(
            //         icon: Icon(Icons.calendar_today), //icon of text field
            //         labelText: "Enter Date" //label text of field
            //     ),
            //     readOnly: true,  // when true user cannot edit text
            //     onTap: () async {
            //       //when click we have to show the datepicker
            //     }
            // ),
            TextButton(onPressed: (){
              // showDatePickerPop(context);
              // _pickDateDialog(context);
              showSpin(context);
            }, child: Text('g'))
          ],
        ));
  }


  void showDatePickerPop(BuildContext context) {
    Future<DateTime?> selectedDate = showDatePicker(
        locale: const Locale('ko', 'KR'), // 한국어 설정
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2020), //시작일
      lastDate: DateTime(2052), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {

    });
  }


  void showSpin(BuildContext context){
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context){
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {

              },
            ),
          ),
        );
      },
      barrierDismissible: true,
    );
  }

}
