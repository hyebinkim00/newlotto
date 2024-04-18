
import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:sqflite/sql.dart';

class byColorController extends GetxController{

  RxString test = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // webviewStart();
    chartTest();
  }

  void chartTest() async {

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

    String url =
        'https://www.dhlottery.co.kr/gameResult.do?method=statByColor&sttDrwNo=14&edDrwNo=1114';

    final response = await http.get(Uri.parse(url));
    final title = RegExp('<title>(.*?)</title>').firstMatch(response.body)?.group(1);

    Future.delayed(const Duration(milliseconds: 1000), () {
      print('Hello, world');
      if(response.statusCode == 200){
        final document = htmlParser.parse(cp949.decodeString(response.body));

        final myNumLists = document.querySelectorAll("div.box_chart");

        print('dd${myNumLists.length}');

        for(var item in myNumLists){
          final d = item.querySelectorAll("li > span");
          print('d${d[0]!.text}');
          print('d${d[1]!.text}');
          final ds = item.querySelectorAll("div#hideDescChart.accessibility");
          print('ds${ds[0].text}');
          final exampleDiv = item.getElementsByClassName("accessibility");
          final textContent = exampleDiv[0].text;
          print('gas${textContent}');

        }
      }

    });






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