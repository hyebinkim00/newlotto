import 'package:cp949_codec/cp949_codec.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:newlotto/main/controller/main_controller.dart';

import '../../../db/dbhelper.dart';
import '../../../model/loto.dart';
import '../../../model/winNums.dart';
import '../../home/controller/home_controller.dart';

class WinningController extends GetxController {
  // final HomeController
  // _myController = Get.find(); // MyController 인스턴스를 가져옵니다.
  RxInt serial = 0.obs;

  RxString resulSe = '0'.obs;
  RxString dated = ''.obs;
  RxList<String> Numbers = <String>['0', '0', '0', '0', '0', '0', '0'].obs;
  RxString bonusNum = '0'.obs;
  List<String> items = [];

  // 당첨금액
  RxList<WinNums> inlist = <WinNums>[].obs;
  RxList<WinNums> inlist2 = [
    WinNums(ranking: '1', people: '0', money: '0'),
    WinNums(ranking: '2', people: '0', money: '0'),
    WinNums(ranking: '3', people: '0', money: '0'),
    WinNums(ranking: '4',people: '0',money: '0'),
    WinNums(ranking: '5',people: '0',money: '0')
  ].obs;

  List<String> num = <String>[]; // 크기가 70이고 모든 요소가 0인 RxList를 생성합니다.

  var selectedValue = 'Initial Value'.obs;

  @override
  void onInit() async {
    // var otherController = Get.find<HomeController>();
    // otherController에서 변수 값을 가져와서 someValue에 할당
    // serial.value = otherController.lastSerial.value;
    List<Loto> list = await DBHelper().getLoto();
    serial.value = list[0].drwNo!;
    setDropItems();
    getWebResult(list[0].drwNo!);
    super.onInit();
  }

  void changeValue(String newValue) {
    serial.value = int.parse(newValue);
  }

  void setDropItems() {
    for (int i = serial.value; i > 0; i--) {
      items.add(i.toString());
    }
    update();
    print('set${items}');
  }

  List<String> getDropdownItems() {
    print('ddssss${items}');
    return items;
  }

  void getWebResult(int num) async {
    List<WinNums> oi = [];
    List<String> nums = [];
    // int num = 1110;
    String url =
        'https://www.dhlottery.co.kr/gameResult.do?method=byWin&drwNo=${num}';

    final response = await http.get(Uri.parse(url));

    if (response.bodyBytes.isEmpty) {
      print('응답이 비어 있습니다.');
      return;
    }

    // 응답이 euc-kr 로 와서 한글이 깨짐 -> cp949 디코딩
    final document = htmlParser.parse(cp949.decodeString(response.body));

    final sel = document.querySelector("div > div.win_result > h4 > strong");
    resulSe.value = sel!.text;

    // 추첨일
    final e = document.querySelector("p.desc");
    dated.value = e!.text;

    // 당첨번호
    final spans = document
        .querySelectorAll("div.win_result > div > div.num.win > p > span");
    for (final span in spans) {
      nums.add(span.text);
      print('ddddsf${span.text}');
    }

    Numbers.value = nums;

    // 보너스 번호
    final bonus = document
        .querySelector("div.win_result > div > div.num.bonus > p > span");
    print('dgwgw${bonus!.text}');

    bonusNum.value = bonus.text;

    // 당첨금액 테이블
    final element = document.querySelectorAll('div > div > table > tbody > tr');

    for (var myNumRow in element) {
      //  tr 한줄씩
      final r = myNumRow.querySelector('td'); // A,B,C...
      // final strongElement = myNumRow.querySelector('strong');
      // final nextTdElement = strongElement!.nextElementSibling;
      final tds1 = myNumRow.querySelector('td:nth-child(3)'); // 순위
      final list = myNumRow.querySelectorAll('td');


      // 동시 당첨자 수

      oi.add(
        // 순위 . 당첨게임 . 1인당 당첨금액
          WinNums(ranking: r!.text, people: list[2].text, money: tds1?.text));
    }

    inlist.value = oi;
    inlist2.value = oi;
    chartTest();
  }

  void chartTest() async{

    String url =
        'https://www.dhlottery.co.kr/gameResult.do?method=statByNumber&sttDrwNo=14&edDrwNo=1114';

    final response = await http.get(Uri.parse(url));
    final document = htmlParser.parse(cp949.decodeString(response.body));

    final myNumList = document.querySelectorAll("#printTarget > tbody > tr");

    for (var td in myNumList){
      // 숫자
      final tds = td.querySelector('span');
      print('testtest1____${tds!.text}');
      // 확률
      final tds2 = td.querySelectorAll('td');
      print('2tddddddd${tds2[2]!.text}');

    }


  }


}
