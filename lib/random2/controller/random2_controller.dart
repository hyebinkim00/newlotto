import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Random2Controller extends GetxController{

  RxString inNum = ''.obs;
  RxString excludeNum = ''.obs;

  RxInt inNumber = 0.obs;
  RxList<List<int>> allRandomNumbers = <List<int>>[].obs;
  late String enteredNumber;

  // animation

  RxBool isSwitched = false.obs;
  RxList<int> includeList = <int>[].obs;
  RxList<int> excludeList = <int>[].obs;

  RxDouble angle = 0.0.obs;
  RxDouble angle2 = 0.0.obs;
  RxBool isBack = false.obs;
  Rx<Color> backgroundColor = Colors.black.obs;

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

  }

  void generateRandomNumber() {
    allRandomNumbers.clear();
    Random random = Random();
    // excludeNumbers: [3,32], includeNumbers: [4,2]

    List<int> numberList = List.generate(45, (index) => index + 1);  // 1 ~ 45  숫자 리스트

    numberList.removeWhere((number) => excludeList.value.contains(number)); // 포함하지 않을 수 빼기

    print('numberListe_${numberList}');



    for(int i = 0 ; i<10 ; i++) { // 열개의 랜덤 리스트
      List<int> resultList = List<int>.from(includeList.value);
      print('reust${resultList}');
      while (resultList.length < 6) {
          int randomIndex = Random().nextInt(numberList.length); //
          print('random${randomIndex}');
          int selectedNumber = numberList[randomIndex];

          if (!resultList.contains(selectedNumber)) {
            resultList.add(selectedNumber);
          }
        }

        print('eee_${resultList}');
      resultList.shuffle();

      // while (resultList.length < 6) {
      //
      //   // // 빼고 싶은 숫자들을 제외하고
      //   // print('gggg${includeList.value}');
      //   // print('gggg${excludeList.value}');
      //   // excludeNumbers = excludeList.value;
      //   // includeNumbers = includeList.value;
      //   // // includeList.value = [2];
      //   // if (!excludeNumbers.contains(randomNumber)) {
      //   //   // 포함하는 숫자들 중 하나를 포함하는 경우
      //   //   if (includeNumbers.any((number) =>
      //   //       randomNumber.toString().contains(number.toString()))) {
      //   //     resultList.add(randomNumber);
      //   //     print('DDDDD_${resultList}');
      //   //   }
      //   //
      //   //   // 둘다 포함하고 싶으면 every
      //   // }
      // }

      allRandomNumbers.add(resultList);
    }

    print('HBsss${allRandomNumbers.toString()}');
  }




}
