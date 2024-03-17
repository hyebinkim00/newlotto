
import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

import '../../model/winNums.dart';



class WinningController extends GetxController {

  RxString s = 'd'.obs;
  RxList<WinNums> inlist = <WinNums>[].obs;


  @override
  void onInit() {

    getWebResult();
    super.onInit();
  }

  void getWebResult()  async {

    List<WinNums> oi = [];
    int num = 1110;
    String url = 'https://www.dhlottery.co.kr/gameResult.do?method=byWin&drwNo=${num}';


    final response = await http
        .get(Uri.parse(url));

    if (response.bodyBytes.isEmpty) {
      print('응답이 비어 있습니다.');
      return;
    }

    // 응답이 euc-kr 로 와서 한글이 깨짐 -> cp949 디코딩
    final document = htmlParser.parse(cp949.decodeString(response.body));
    final element = document.querySelectorAll(
        'div > div > table > tbody > tr');

    //

    for (var myNumRow in element) { //  tr 한줄씩
      final r = myNumRow.querySelector('td'); // A,B,C...
      // final strongElement = myNumRow.querySelector('strong');
      // final nextTdElement = strongElement!.nextElementSibling;
      final tds = myNumRow.querySelector('td:nth-child(1)'); // 순위
      final tds1 = myNumRow.querySelector('td:nth-child(3)'); // 순위
      final tds3 = myNumRow.querySelector('td:nth-child(4)'); // 순위
      final list = myNumRow.querySelectorAll('td');


      // 동시 당첨자 수
      print('ddd${list[2].text}');

      oi.add(WinNums(ranking: r!.text,people:list[2].text,money: tds1?.text ));


      for (var di in list){
        print('tdtssd2__ ${di.text}');
      }
    }

    inlist.value = oi;
  }

}