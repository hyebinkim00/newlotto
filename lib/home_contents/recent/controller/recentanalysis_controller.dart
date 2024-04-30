import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../db/dbhelper.dart';
import '../../../model/loto.dart';

class RecentAnalysisController extends GetxController    with GetSingleTickerProviderStateMixin {

  RxList<Loto> list = <Loto>[].obs;
  RxInt currentIndex = 0.obs;

  RxString mostNum = ''.obs;
  RxString mostNumf = ''.obs;
  RxString LeastNum = ''.obs;
  RxString leastNumf = ''.obs;

  RxList<List<int>> oddList = <List<int>>[].obs;
  RxList<List<int>> evenList = <List<int>>[].obs;

  late TabController tabController;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    List<Loto> lotos = await DBHelper().getLoto();
    print('EEEEE${lotos.length}');

    list.value = lotos;

    List<int> combinedList = [];
    for (var list in lotos) {
      combinedList.addAll(list.getLists());

    }

    // loto
    findMostFrequentNumbers(combinedList);
    findLeastFrequentNumbers(combinedList);
   await oddoreven(lotos);

    // print('EFEFES___${rankList([[1,2,3,4,5],[1,2],[3,4,5]])}');
    // print('EFEFESs___${findMostFrequentNumbers([1,2,3,4,4,4,5,5,5])}');
    // print('EFEFESs___${findLeastFrequentNumbers([1,2,3,3,4,4,4,5,5,5])}');

  }


  void changeWidget(){
    if(currentIndex==0){

    } else{

    }
  }

  //Future .then


  Map<T, int> rankList<T>(List<T> list) {
    Map<T, int> frequencyMap = {};

    // 리스트에서 각 요소의 등장 횟수를 계산
    for (var item in list) {
      frequencyMap[item] = (frequencyMap[item] ?? 0) + 1;
    }

    // 등장 횟수에 따라 요소들을 정렬
    List<MapEntry<T, int>> sortedEntries = frequencyMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // 정렬된 요소들의 순위를 매김
    Map<T, int> rankMap = {};
    for (int i = 0; i < sortedEntries.length; i++) {
      rankMap[sortedEntries[i].key] = i + 1;
    }

    return rankMap;
  }


  Map<T, int> rankList2<T>(List<List<T>> listOfLists) {
    Map<T, int> frequencyMap = {};

    // 모든 리스트의 요소를 하나의 리스트로 합침
    List<T> flattenedList = listOfLists.expand((list) => list).toList();

    // 리스트에서 각 요소의 등장 횟수를 계산
    for (var item in flattenedList) {
      frequencyMap[item] = (frequencyMap[item] ?? 0) + 1;
    }

    // 등장 횟수에 따라 요소들을 정렬
    List<MapEntry<T, int>> sortedEntries = frequencyMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // 정렬된 요소들의 순위를 매김
    Map<T, int> rankMap = {};
    for (int i = 0; i < sortedEntries.length; i++) {
      rankMap[sortedEntries[i].key] = i + 1;
    }

    return rankMap;
  }

  void findMostFrequentNumbers(List<int> list) {
    // 각 숫자의 등장 횟수를 저장할 맵
    Map<int, int> frequencyMap = {};

    // 리스트를 반복하면서 각 숫자의 등장 횟수를 계산
    for (int number in list) {
      frequencyMap[number] = (frequencyMap[number] ?? 0) + 1;
    }

    // 등장 횟수가 가장 큰 숫자들을 찾음
    int maxFrequency = frequencyMap.values.reduce((value, element) => value > element ? value : element);
    List<int> mostFrequentNumbers = [];

    frequencyMap.forEach((number, frequency) {
      if (frequency == maxFrequency) {
        mostFrequentNumbers.add(number);
      }
    });

    mostNum.value = mostFrequentNumbers.toString();
    mostNumf.value = maxFrequency.toString();
    print('ddd${maxFrequency}'); // 횟수


  }

   void findLeastFrequentNumbers(List<int> list) {
    // 각 숫자의 등장 횟수를 저장할 맵
    Map<int, int> frequencyMap = {};
    List<int> lotos = List.generate(45, (index) => index+1);
    print('HHHH${lotos}');

    // 리스트를 반복하면서 각 숫자의 등장 횟수를 계산
    for (int number in list) {
      lotos.remove(number);
      frequencyMap[number] = (frequencyMap[number] ?? 0) + 1;
    }

    // 한번도 안나온 숫자
    print('HHHH${lotos}');
    LeastNum.value = lotos.toString();

    // 등장 횟수가 가장 작은 숫자들을 찾음
    int minFrequency = frequencyMap.values.reduce((value, element) => value < element ? value : element);
    List<int> leastFrequentNumbers = [];

    frequencyMap.forEach((number, frequency) {
      if (frequency == minFrequency) {
        leastFrequentNumbers.add(number);
      }


        print('HBS${frequencyMap.toString()}');
    });

    print('가장 작은 등장 횟수: $minFrequency');

    // LeastNum.value = leastFrequentNumbers.toString();
    leastNumf.value = minFrequency.toString();

  }


  Map<int, int> findMostFrequentNumbers2(List<int> list) {
    // 각 숫자의 등장 횟수를 저장할 맵
    Map<int, int> frequencyMap = {};

    // 리스트를 반복하면서 각 숫자의 등장 횟수를 계산
    for (int number in list) {
      frequencyMap[number] = (frequencyMap[number] ?? 0) + 1;
    }

    // 등장 횟수가 가장 큰 숫자들을 찾음
    int maxFrequency = frequencyMap.values.reduce((value, element) => value > element ? value : element);
    Map<int, int> mostFrequentNumbers = {};

    frequencyMap.forEach((number, frequency) {
      if (frequency == maxFrequency) {
        mostFrequentNumbers[number] = frequency;
      }
    });

    return mostFrequentNumbers;
  }

  Future<void> oddoreven(List<Loto> combinedList) async {

    List<List<int>> e = [];
    List<List<int>> o = [];



    for(Loto n in combinedList){
      List<int> evens = [];
      List<int> odds = [];
      for (int nums in n.getLists()){
        if(nums%2 == 0){
          evens.add(nums);
        }else {
          odds.add(nums);
        }

      }
      if(evens.isEmpty){
        evens.add(43);
      }

      print('eveeeee_${evens.toString()}');
      print('ovene__${odds.toString()}');
      e.add(evens);
      o.add(odds);


      print('EE_______${evens.toString()}');

    }

    oddList.value = o;
    evenList.value = e;

    print('odd___${oddList.toString()}');
    print('even___${evenList.toString()}');

  }

}