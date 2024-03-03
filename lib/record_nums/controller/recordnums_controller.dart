
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/model/myNums.dart';

import '../../db/dbhelper.dart';
import '../../model/newNum.dart';
import '../../model/numInfo.dart';
import '../../model/qrInfo.dart';
import '../../model/qr_scan.dart';
import '../../model/selfnum.dart';

class RecordNumsController extends GetxController
    with GetSingleTickerProviderStateMixin{
  // RxList<List<NumData>> QRballLists = <List<NumData>>[].obs;

  RxInt Selfserial = 0.obs;
  RxInt Qrserial = 0.obs;

  RxInt currentIndex = 0.obs;

  late TabController tabController;

  RxList<MyNums> qrList =  <MyNums>[].obs;
  RxList<MyNums> selfList = <MyNums>[].obs;


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    getSerial();
    // getQrcodeList();
  }


  Future<void> getSerial() async {

    // Self 저장 된 리스트중 제일 큰 회차로 시작
    List<MyNums> selfListOrigin = await DBHelper().getSelfLastserial();
    if(selfListOrigin.isNotEmpty){
      Selfserial.value = selfListOrigin[0].serial!;
    }
    List<MyNums> qrListOrigin = await DBHelper().getQrLastserial();
    if(qrListOrigin.isNotEmpty){
      Qrserial.value =  qrListOrigin[0].serial!;
      List<MyNums> dbListsf = await DBHelper().queryByColumnQr(Qrserial.value);
      qrList.value  = dbListsf;
    }

    itemsListUpdate();

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

  static Future<List<List<selforigin>>> getDetail(int ser, List<NumInfo> mynums) async {
    // 회차(ser) 에 대한 당첨번호 (loto 테이블)
    List<int> winNums =  await DBHelper().queryByColumnDrwno(ser);

    List<List<selforigin>> nus = [];
    int sx = mynums.length;
    print('hbhb__my${sx}');
    // sx ( mynums 갯수만큼 반복)

    for (int i = 0 ; i < sx ; i++){
      List<selforigin>  n = [];
      List<int> m = [mynums[i].num1??0, mynums[i].num2??0, mynums[i].num3??0, mynums[i].num4??0, mynums[i].num5??0,mynums[i].num6??0];

      print('hbhb__mmm${m.toString()}');

      for(var i in m){
        print('ddddddd${m.toString()}');

        if(winNums.contains(i)){
          n.add(selforigin(color:getColors(i as int),number: i));
        } else{
          n.add(selforigin(color: Colors.grey,number: i));
        }
        print('nnnnnnnnnn${n}');
      }

      nus.add(n);
    }


    print('nus${nus.toString()}');
    return nus;
    // QRINFO 리스트 개수 , 공 리스트
  }


  static Color getColors(int num){
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


  void serialMinus() async{
    if(tabController.index==0){
      Selfserial.value--;
     print('updatesss__${update}');
   } else{
      Qrserial.value--;
   }
    itemsListUpdate();
  }

  void serialPlus() async{
    if(tabController.index==0){Selfserial.value++;
    }else{
     Qrserial.value++;
    }
    itemsListUpdate();
  }

  void itemsListUpdate() async {
    print('DDEdddddddd${tabController.index}');
    if(currentIndex==0){
      List<MyNums> dbListsf = await DBHelper().queryByColumnSelf(Selfserial.value);
      selfList.value  = dbListsf;
    } else {
      List<MyNums> dbListsf = await DBHelper().queryByColumnQr(Qrserial.value);
      qrList.value  = dbListsf;
    }
  }

}