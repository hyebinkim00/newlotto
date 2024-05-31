import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

import '../../../../db/dbhelper.dart';
import '../../../../model/loto.dart';


class NumChartController extends GetxController{


  RxList<String> startNum = <String>[].obs ;
  RxList<String> endNum = <String>[].obs;
  RxInt selectedStart = 1.obs;
  RxInt selectedEnd = 0.obs;

  RxList nums = [].obs;
  RxList<String> percent = <String>[].obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    List<Loto> list = await DBHelper().getLoto();
    selectedEnd.value = list[0].drwNo!;
    print('gsdgdd${selectedEnd.value}');
    startNum.value = List.generate(selectedEnd.value, (index) => '${index+1}');
    endNum.value = List.generate(selectedEnd.value, (index) => '${selectedEnd.value-index}');

  }

  void chartTest() async {

    List<String> chartNum = [];
    List<String> chartPer = [];


    String url = 'https://www.dhlottery.co.kr/gameResult.do?method=statByNumber&sttDrwNo=${selectedStart}&edDrwNo=${selectedEnd}';

    final response = await http.get(Uri.parse(url));
    final document = htmlParser.parse(cp949.decodeString(response.body));

    final myNumList = document.querySelectorAll("#printTarget > tbody > tr");

    for (var td in myNumList){
      // 숫자
      final tds = td.querySelector('span');
      print('testtest1____${tds!.text}');
      chartNum.add(tds!.text);

      // 횟수
      final tds2 = td.querySelectorAll('td');
      chartPer.add(tds2[2]!.text);

      print('2tddddddd${tds2[2]!.text}');
    }


    // 1427 1540 1406 1495 738
    nums.value = chartNum;
    percent.value = chartPer;


  }



}