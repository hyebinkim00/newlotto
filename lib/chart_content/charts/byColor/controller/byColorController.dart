
import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:sqflite/sql.dart';

import '../../../../config/shared_pre.dart';
import '../../../../db/dbhelper.dart';
import '../../../../model/loto.dart';

class byColorController extends GetxController{

  final SharedPreferencesService _prefsService = SharedPreferencesService.getInstance();

  RxList<String> startNum = <String>[].obs ;
  RxList<String> endNum = <String>[].obs;
  RxString test = ''.obs;

  RxInt selectedStart = 1.obs;
  RxInt selectedEnd = 0.obs;

  RxList<double> pielist = <double>[].obs;


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // List<Loto> list = await DBHelper().getLoto();
    // await _prefsService.init();
    // selectedEnd.value = list[0].drwNo!;
    selectedEnd.value = _prefsService.getInt('lastSerial');
    print('gsdgdd${selectedEnd.value}');
    startNum.value = List.generate(selectedEnd.value, (index) => '${index+1}');
    endNum.value = List.generate(selectedEnd.value, (index) => '${selectedEnd.value-index}');
    chartTest();
  }

  void chartTest() async {


    List<int> chartPer = [];

    String url =
        'https://www.dhlottery.co.kr/gameResult.do?method=statByNumber&sttDrwNo=${selectedStart}&edDrwNo=${selectedEnd}&sltBonus=0';

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
    pielist.value = percentages3;

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