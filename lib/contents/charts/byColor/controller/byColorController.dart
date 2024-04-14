import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

class byColorController extends GetxController{

  void chartTest() async {

    List<String> chartNum = [];
    List<String> chartPer = [];


    String url =
        'https://www.dhlottery.co.kr/gameResult.do?method=statByColor&sttDrwNo=14&edDrwNo=1114';

    final response = await http.get(Uri.parse(url));
    final document = htmlParser.parse(cp949.decodeString(response.body));

    final myNumList = document.querySelectorAll("#printTarget > tbody > tr");

    for (var td in myNumList){
      // 숫자
      final tds = td.querySelector('span');
      print('testtest1____${tds!.text}');
      chartNum.add(tds!.text);

      // 확률
      final tds2 = td.querySelectorAll('td');
      chartPer.add(tds2[2]!.text);

      print('2tddddddd${tds2[2]!.text}');
    }



  }


}