import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Random2Controller extends GetxController{

  RxBool isSwitched = false.obs;

  RxString inNum = ''.obs;
  RxInt inNumber = 0.obs;
  RxList<List<int>> allRandomNumbers = <List<int>>[].obs;
  late String enteredNumber;

  // animation

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

  void create_list(){
    allRandomNumbers.clear();
    enteredNumber  = '3';
    var random = Random();
    isSwitched.value = !isSwitched.value;
    print('hhhh $isSwitched');
    for (var i = 0; i < 15; i++) {
      List<int> randomNumbers = [];
      // 1부터 45까지의 숫자 중에서 랜덤으로 6개 선택
      while (randomNumbers.length < 6) {
        int randomNumber = random.nextInt(45) + 1;
        if (randomNumber != int.parse(enteredNumber)){
          randomNumbers.add(randomNumber);
        }
      }

      inNumber.value = 6;
      // 리스트를 정렬
      randomNumbers.sort();

      // 생성된 랜덤 숫자 리스트를 전체 리스트에 추가
      allRandomNumbers.add(randomNumbers);

    }
  }

  void generateRandomNumber({required List<int> excludeNumbers, required List<int> includeNumbers}) {
    Random random = Random();

    for(int i = 0 ; i<10 ; i++) {
      List<int> resultList = [];

      while (resultList.length < 6) {
        print('kkk${resultList.toString()}');
        int randomNumber = random.nextInt(45) + 1; // 1부터 45까지의 랜덤한 수 생성
        // 빼고 싶은 숫자들을 제외하고
        if (!excludeNumbers.contains(randomNumber)) {
          // 포함하는 숫자들 중 하나를 포함하는 경우
          if (includeNumbers.any((number) =>
              randomNumber.toString().contains(number.toString()))) {
            resultList.add(randomNumber);
          }

          // 둘다 포함하고 싶으면 every
        }
      }
      allRandomNumbers.add(resultList);
    }
    print('HBsss${allRandomNumbers.toString()}');
  }




}
