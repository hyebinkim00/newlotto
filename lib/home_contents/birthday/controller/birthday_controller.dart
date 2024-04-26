import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BirthDayController extends GetxController{

  RxDouble angle = 0.0.obs;
  RxDouble angle2 = 0.0.obs;
  RxBool isBack = true.obs;
  Rx<Color> backgroundColor = Colors.transparent.obs;
  int luckyNum = 0;

  int birthday = 0;

  void onTap() {
    // angle.value = (angle.value + pi) % (2 * pi);
    angle.value = (angle.value + 180) % 360; // 180도 회전

  }
  void onTap2(){
    angle.value = (angle.value + pi) % (2 * pi);
    isBack.value = !isBack.value;
    backgroundColor.value = isBack.value ? Colors.black : Colors.yellowAccent;
  }


  void onTap3(){
    isBack.value = !isBack.value;
    backgroundColor.value = isBack.value ? Colors.transparent : Colors.yellowAccent;

  }

  final TextEditingController textEdit = TextEditingController();


  String f='';

  void showDatePickerPop(BuildContext context) {
    Future<DateTime?> selectedDate = showDatePicker(
      locale: const Locale('ko', 'KR'), // 한국어 설정
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(1900), //시작일
      lastDate: DateTime(2040), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {
      print('BBBBir${dateTime}');
      DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
      textEdit.text = dateFormat.format(dateTime!);
      DateFormat dateFormat2 = DateFormat('yyyyMMdd');
      int s = int.parse(dateFormat2.format(dateTime));
      print('DDDa${s}');
      birthday = dateTime.year * 10000 + dateTime.month * 100 + dateTime.day;

    });



  }


  void generateTodayNumber() {
    // 생일 값을 1부터 45까지의 숫자 범위로 매핑
    // int mappedBirthday = (birthday % 45) + 1;

    if(birthday==0){
      Fluttertoast.showToast(msg:'생일을 입력해주세요!');
      return;
    }
    DateTime now = DateTime.now();
    // 오늘의 날짜와 생일 값을 조합하여 무작위 숫자 생성
    print('birs_${birthday}');
    int seed = now.year * 10000 + now.month * 100 + now.day + birthday;
    Random random = Random(seed);
    int d = random.nextInt(45) + 1;
    luckyNum =  d;
    isBack.value = !isBack.value;
    angle.value = (angle.value + pi) % (2 * pi);
    backgroundColor.value = isBack.value ? Colors.transparent : Colors.yellowAccent;
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