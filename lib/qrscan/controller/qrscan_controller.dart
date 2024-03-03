import 'package:cp949_codec/cp949_codec.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../model/myNums.dart';
import '../../model/newNum.dart';
import '../../model/qr_scan.dart';
import '../../ui/dialog_utils.dart';

class QrscanController extends GetxController{
  RxString totalResponse = "".obs;

  late int serialRes;
  late String dateRes;
  late String winResultRes;


  late List<NumData> winnerLists=[];
  late List<NumData> myNumLists=[];
  List<newNum> list = [];
  List<myNums> listss = [];
  late qrScan qtinfo;
  QRViewController? qrViewController;

  // https://m.dhlottery.co.kr/qr.do?method=winQr&v=1095q061721243839q020304213138q143031414243q050609202731q1314214043451843447017

  void barcodeResult(String barcodeData) async {
    qrViewController!.resumeCamera();
    final response = await http.get(Uri.parse('https://m.dhlottery.co.kr/qr.do?method=winQr&' + barcodeData));
    if (response.bodyBytes.isEmpty) {
      print('응답이 비어 있습니다.');
      return;
    }
    if(response.body.isNotEmpty) {
      // 응답이 euc-kr 로 와서 한글이 깨짐 -> cp949 디코딩
      final document = htmlParser.parse(cp949.decodeString(response.body));

      //정보//
      // 로또 6/45
      // 회차번호(serial) 추첨일(date)
      // 당첨번호 (winner_list) (보너스는 plus) <!-- 번호별 컬러값: clr1: 1~10(노란) , clr2: 11~20(파란), clr3: 21~30(빨간), clr4: 31~40(검은), clr5: 41~45(초록) -->
      // 고른번호 (myNumList) -> th : 행 번호 (A~) , td :결과 ,

      // 회차번호
      final serial = document.querySelector(
          '#container > div.contents > div.winner_number > h3 > span.key_clr1');
      print('hbhbSer' + serial!.text);
      String numberString = serial!.text.replaceAll('제', '');
      String d = numberString.replaceAll('회', '') ;
      serialRes = int.parse(d);
      // 추첨일
      final date = document.querySelector(
          '#container > div.contents > div.winner_number > h3 > span.date');
      dateRes = date!.text;

      // 결과 텍스트
      final noticeWinner = document.querySelector(
          "#container > div.contents > div.winner_number > div.bx_notice.winner");

      winResultRes = noticeWinner!.text!.trim();

      // 당첨 번호 winnerLists ( className에 컬러값 , text에 번호)
      final winnerList = document.querySelectorAll(
          '#container > div.contents > div.winner_number > div.bx_winner.winner > div.list > div');
      for (var item in winnerList) {
        winnerLists.add(
            NumData(number: item.text, color: getColor(item.className)));
      }
      winnerLists.insert(6, NumData(number: '+',color: Colors.transparent));


      // 고른 번호

      final myNumList = document.querySelectorAll(
          "#container > div.contents > div.list_my_number > div > table > tbody > tr");

      // myNumList 한개에 행 하나(A,B,C,D,,,)

      for (var myNumRow in myNumList) {
        final th = myNumRow.querySelector('th'); // A,B,C...
        final td = myNumRow.querySelector('td'); // 행별로 결과

        List<NumData> nums = [];

        // 한 행에 span 으로 번호 잇음 tb 6개
        final tb = myNumRow.querySelectorAll('span');

        for (var myNum in tb) {
          nums.add(NumData(number: myNum.text, color: getColor(myNum.className)));
        }
        listss.add(myNums(lists: nums,results: td!.text));
      }

    }

    qtinfo =qrScan(serial: serialRes, date: dateRes,winnerList: winnerLists,notice: winResultRes,selectednums:listss );

    DialogUtils.qrResult(qtinfo);
  }

  Color getColor(String num){
    if(num.contains('clr1')){
      return Colors.yellowAccent;
    } else if (num.contains('clr2')){
      return Colors.blueAccent;
    } else if (num.contains('clr3')){
      return Colors.redAccent;
    } else if (num.contains('clr4')){
      return Colors.black;
    }else if(num.contains('clr5')){
      return Colors.greenAccent;
    }else{
      return Colors.transparent;
    }
  }


}