import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BirthDayController extends GetxController{


  final TextEditingController textEdit = TextEditingController();


  String f='';

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

    //showCupertinoDialog
    showDialog(
      context: context,
      builder: (BuildContext context){

        return Column(
          children: [
            TextButton(onPressed: (){
              textEdit.text = f;
              Navigator.of(context).pop();


            }, child: Text('확인')),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                height: 300,
                child: CupertinoDatePicker(
                  dateOrder: DatePickerDateOrder.ymd,
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime date) {
                    DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
                    f = dateFormat.format(date);
                    print('fff${f}');
                  },
                ),
              ),
            ),
          ],
        );
      },
      barrierDismissible: true, // 외부 선택

    );
  }



}