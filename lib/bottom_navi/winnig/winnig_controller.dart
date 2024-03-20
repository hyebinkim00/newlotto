
import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:newlotto/main/controller/main_controller.dart';

import '../../model/winNums.dart';
import '../home/home_controller.dart';



class WinningController extends GetxController {
  // final HomeController _myController = Get.find(); // MyController 인스턴스를 가져옵니다.
  RxInt s = 0.obs;
  RxList<WinNums> inlist = <WinNums>[].obs;
  RxList<WinNums> inlist2 = [WinNums(),WinNums(),WinNums(), WinNums(),WinNums()].obs;

  List<String> num = <String>[]; // 크기가 70이고 모든 요소가 0인 RxList를 생성합니다.

  var selectedValue = 'Initial Value'.obs;

  @override
  void onInit() {
    var otherController = Get.find<HomeController>();
    // otherController에서 변수 값을 가져와서 someValue에 할당
    s.value = otherController.lastSerial.value;
    getWebResult(otherController.lastSerial.value);
    super.onInit();
  }

  void changeValue(String newValue) {
    selectedValue.value = newValue;
  }

  List<String> getDropdownItems() {
    List<String> items = [];
    for (int i = s.value; i > 0; i--) {
      items.add(i.toString());
    }
    return items;

  }

  void getWebResult(int num) async {

    List<WinNums> oi = [];
    // int num = 1110;
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
    inlist2.value = oi;

  }

}