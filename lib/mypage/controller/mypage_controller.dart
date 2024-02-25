
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../db/dbhelper.dart';
import '../../model/newNum.dart';
import '../../model/numInfo.dart';
import '../../model/qrInfo.dart';
import '../../model/qr_scan.dart';
import '../../model/selfnum.dart';

class MyPageController extends GetxController
    with GetSingleTickerProviderStateMixin{
  // RxList<List<NumData>> QRballLists = <List<NumData>>[].obs;


  RxInt Selfserial = 0.obs;
  RxInt Qrserial = 0.obs;
  late RxInt rxValue = 100.obs;
  RxInt currentIndex = 0.obs;

  late TabController tabController;

  RxList<qrInfo> qrtest =  <qrInfo>[].obs;
  RxList<selfNum> dblist = <selfNum>[].obs;


  @override
  void onInit() {
    super.onInit();
    // rxValue = Get.arguments['lastSerial'];
    tabController = TabController(length: 2, vsync: this);
    getSerial();
    getQrcodeList();
  }


  Future<void> getSerial() async {
    // MainController mainController = Get.find<MainController>();
    // print('ggg+${mainController.lastSerial}');
    Qrserial.value = rxValue.value;

    // 저장 된 리스트중 제일 큰 회차로 시작
    List<selfNum> dbListf = await DBHelper().getselfLastserial();
    Selfserial.value = dbListf[0].serial!;
    print('ddfdf${dbListf[0].serial}');
    getSelfList(dbListf[0].serial!);
  }

  // DB(selfNum)에 저장된 값 불러오기 ListView 테이블 한 행씩
  Future<void> getSelfList(int serial) async {
    List<selfNum> dbList = await DBHelper().queryByColumnSelf(serial);
    dblist.value = dbList;
  }


  Future<List<numInfo>> getResults(selfNum se) async {
    List<numInfo>  n = [];
    // 해당 회차 당첨 번호 불러옴
    List<int> winNums =  await DBHelper().queryByColumnDrwno(se.serial);
    List<int> sl = [se.num1??0,se.num2??0,se.num3??0,se.num4??0,se.num5??0,se.num6??0];
    print('sew___${sl.length}');
    for(var i in sl){
      print('weg$i'+winNums.toString());
      if(winNums.contains(i)){
        n.add(numInfo(color:getColors(i),number: i));
      } else{
        n.add(numInfo(color: Colors.transparent,number: i));
      }
    }
    return n;
  }


  Future<void> getQrcodeList() async {
    List<qrInfo> qr = await DBHelper().getAllNumLists();
    print('sgsgsg+${qr.length}');
    for(qrInfo info in qr) {
      List<newNum> numInfoList = info.myNum ?? [];
      print('sgsgsg___${numInfoList.length}');
    }
    qrtest.value = qr;
  }

  Future<List<List<NumData>>> getTEST(int ser, List<newNum> mynums) async {
    List<int> winNums =  await DBHelper().queryByColumnDrwno(ser);

    List<List<NumData>> nus = [];
    int sx = mynums.length;
    print('hbhb__my${sx}');
    // sx ( mynums 갯수만큼 반복)

    for (int i = 0 ; i < sx ; i++){
      List<NumData>  n = [];
      List<String> m = [mynums[i].num1??'0' , mynums[i].num2??'0', mynums[i].num3??'0',
        mynums[i].num4??'0', mynums[i].num5??'0',mynums[i].num6??'0'];
      print('hbhb__mmm${m.toString()}');

      for(var i in m){
        if(winNums.contains(i)){
          n.add(NumData(color:getColors(i as int),number: i));
        } else{
          n.add(NumData(color: Colors.grey,number: i));
        }
        print('nnnnnnnnnn${n}');
      }
      nus.add(n);
    }

    return nus;
    // QRINFO 리스트 개수 , 공 리스트
  }


  Color getColors(int num){
    //     1번부터 10번까지는 노란색입니다.
    // 11번 부터 20번까지는 파란색입니다.
    // 21번부터 30번까지는 빨간색입니다.
    // 31번부터 40번까지는 검은색입니다.
    // 41번부터 45번까지는 초록색입니다.
    if (1 <= num && num <= 10) {
      return Colors.yellowAccent;
    }else if(11 <= num && num <= 20){
      return Colors.blueAccent;
    }else if(21 <= num && num <= 30){
      return Colors.redAccent;
    }else if(31 <= num && num <= 40){
      return Colors.black;
    }else {
      return Colors.green;
    }
  }


  void serialMinus() {
    //  최대보다 안올라가게
    print('tttaabb_${tabController.index}');
   if(tabController.index==0){
     Selfserial.value--;
     getSelfList(Selfserial.value);
   }else{
     Qrserial.value--;
   }
  }

  void serialPlus() {
    if(tabController.index==0){
      Selfserial.value++;
      getSelfList(Selfserial.value);
    }else{
      Qrserial.value--;
    }
  }

}