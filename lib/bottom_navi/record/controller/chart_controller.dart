import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;


class RecordController extends GetxController {

  void getWeb(int startNum,int,endNum) async{
    String url =
        'https://m.dhlottery.co.kr/gameResult.do?method=statByNumber&sttDrwNo=${startNum}&edDrwNo=${endNum}';

    final response = await http.get(Uri.parse(url));

    if (response.bodyBytes.isEmpty) {
      print('응답이 비어 있습니다.');
      return;
    }

    // 응답이 euc-kr 로 와서 한글이 깨짐 -> cp949 디코딩
    final document = htmlParser.parse(cp949.decodeString(response.body));

    final sel = document.querySelector("div > div.win_result > h4 > strong");



  }

}