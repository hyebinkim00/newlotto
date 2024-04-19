
import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:sqflite/sql.dart';

class byColorController extends GetxController{
  List<String> startNum = List.generate(1115, (index) => '${index+1}');
  List<String> endNum = List.generate(1115, (index) => '${1115-index}');
  RxString test = ''.obs;

  RxInt seleNum = 0.obs;
  RxInt sele2Num = 0.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // webviewStart();
  }

  void chartTest() async {


    List<int> chartPer = [];

    String url =
        'https://www.dhlottery.co.kr/gameResult.do?method=statByNumber&sttDrwNo=${seleNum}&edDrwNo=${sele2Num}&sltBonus=0';

    final response = await http.get(Uri.parse(url));
    final document = htmlParser.parse(cp949.decodeString(response.body));

    final myNumList = document.querySelectorAll("#printTarget > tbody > tr");

    for (var td in myNumList){

      // 횟수
      final tds2 = td.querySelectorAll('td');
      chartPer.add(int.parse('${tds2[2]!.text}'));
      print('2tddddddd${tds2[2]!.text}');
    }

    sum5(chartPer);
  }



  void sum5 (List<int> lists){
    // Piechart 퍼센트 구하기
    int total = lists.reduce((value, element) => value + element);
    print('ttt${total}');
    List<int> sums = [];

    for (int i = 0; i < lists.length; i += 10) {
      int sum = lists.skip(i).take(10).reduce((value, element) => value + element);
      sums.add(sum);
    }
    print('sumsss${sums.toString()}');

    List<double> percentages3 = sums.map((value) => ((value / total) * 100 * 10).roundToDouble() / 10).toList();

    print('FixPPPPP${percentages3}');


    test.value = percentages3.toString();
  }



  void percent(){

    List<int> data = List.generate(45, (index) => index + 1);

    // 총합 계산
    int total = data.reduce((value, element) => value + element);

    // 비율 계산 및 백분율로 변환
    List<double> percentages = data.map((value) => (value / total) * 100).toList();

    // 결과 출력
    print('각 숫자의 비율:');
    for (int i = 0; i < data.length; i++) {
      print('${data[i]}: ${percentages[i].toStringAsFixed(2)}%');
    }

  }

  //
  // Future<void> webviewStart() async {
  //   webViewController
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..loadRequest(Uri.parse('https://www.dhlottery.co.kr/gameResult.do?method=statByColor&sttDrwNo=14&edDrwNo=1114'));
  //   final d =  document.getElementById('hideDescChart');
  //   print ('dddsss${d!.outerHtml}');
  //
  //
  //
  // }

}