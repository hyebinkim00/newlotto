import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

import '../../../../db/dbhelper.dart';
import '../../../../model/loto.dart';

class byPickController extends GetxController{

  // 63 으로 int 로
  RxList<int> selec = <int>[63,63,63,63,63,63].obs;

  final List<List<int>> sum = [];

  RxMap<int, double> met1 = <int, double>{}.obs;
  RxMap<int, double> met2 = <int, double>{}.obs;

  // 각 번호의 당첨 횟수를 전체 추첨 횟수로 나누어 계산합니다.
  // 각 번호의 당첨 횟수를 모든 번호의 당첨 횟수 합으로 나누어 계산합니다.

  @override
  void onInit(){
    chartTest();
  }




  Map<int, int> calculateNumberFrequencies() {
    print('ggggg${sum}');
    Map<int, int> numberFrequencies = {};
    for (var draw in sum) {
      for (var number in draw) {
        numberFrequencies[number] = (numberFrequencies[number] ?? 0) + 1;
      }
    }
    return numberFrequencies;
  }


  void chartTest() async {
    List<Loto> list = [];

    // 저장되어 있는 값 확인
    list = await DBHelper().getLoto();
    print('ls${list}');

    await Future.forEach(list, (list) async {
      sum.add(list.getSums());
    });


    calculateProbabilitiesMethod1([1,2,3,4,5]);
    calculateProbabilitiesMethod2([1,2,3,4,5]);

    }



    void calculateProbabilitiesMethod1(List<int> userNumbers) {
    final numberFrequencies = calculateNumberFrequencies();
    Map<int, double> probabilities = {};
    final totalDraws = pastWinningNumbers.length; // 전체 추첨 횟수

    for (var number in userNumbers) {
      int frequency = numberFrequencies[number] ?? 0; // 해당 번호의 당첨 빈도
      probabilities[number] = frequency / totalDraws; // 빈도를 전체 추첨 횟수로 나누어 확률 계산
    }
    print('1TTTTTT${probabilities}');
    met1.value = probabilities;
    // return probabilities;
  }

  // 방법 2: 사용자 번호에 대한 확률 계산 (전체 번호의 당첨 횟수 합을 기준으로)
  void  calculateProbabilitiesMethod2(List<int> userNumbers) {
    final numberFrequencies = calculateNumberFrequencies();
    print('dd${numberFrequencies}');
    Map<int, double> probabilities = {};
    final totalOccurrences = numberFrequencies.values.reduce((a, b) => a + b); // 전체 번호의 당첨 횟수 합

    for (var number in userNumbers) {
      int frequency = numberFrequencies[number] ?? 0; // 해당 번호의 당첨 빈도
      probabilities[number] = frequency / totalOccurrences; // 빈도를 전체 번호의 당첨 횟수 합으로 나누어 확률 계산
    }
    met2.value = probabilities;
    print('2TTTTTT${probabilities}');
  }


}


  // 과거 당첨 번호 데이터 (예시)
  final List<List<int>> pastWinningNumbers = [
    [1, 13, 5, 7, 9, 11],
    [2, 14, 6, 18, 10, 12],
    [1, 12, 13, 41, 35, 46],
    // ... 추가 데이터
  ];

  // 번호별 당첨 횟수 계산

  // 방법 1: 사용자 번호에 대한 확률 계산 (전체 추첨 횟수를 기준으로)




