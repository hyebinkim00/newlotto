
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/model/myNums.dart';

import '../../../../db/dbhelper.dart';
import '../../../../model/numInfo.dart';

import '../../../../model/qrScan.dart';

class PurchaseController extends GetxController
    with GetSingleTickerProviderStateMixin{
  // RxList<List<NumData>> QRballLists = <List<NumData>>[].obs;

  RxInt Selfserial = 0.obs;
  RxInt Qrserial = 0.obs;

  RxInt currentIndex = 0.obs;

  late TabController tabController;

  // 해당 회차에 대한 번호 리스트 정보
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

    itemsListFirst();

  }



  static Future<List<List<selforigin>>> getDetail(int ser, List<NumInfo> mynums) async {
    // 회차(ser) 에 대한 당첨번호 (loto 테이블)

    print('getDetail__HB${ser}__${mynums.length}');

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
    if(tabController.index==0){
      Selfserial.value++;
    }else{
     Qrserial.value++;
    }
    itemsListUpdate();
  }

  void itemsListUpdate() async {
    print('DDEdddddddd${tabController.index}');
    if(currentIndex==0){
      // 직접 입력 탭
      List<MyNums> dbListsf = await DBHelper().queryByColumnSelf(Selfserial.value);
      print('DDEdddddddd${dbListsf}');
      selfList.value  = dbListsf;
    } else {
      // QR 스캔 탭
      List<MyNums> dbListsf = await DBHelper().queryByColumnQr(Qrserial.value);
      print('DDEdddddddd${dbListsf}');

      qrList.value  = dbListsf;
    }
  }

  void itemsListFirst() async {
    print('DDEdddddddd${tabController.index}');

      // 직접 입력 탭
      List<MyNums> dbListsf = await DBHelper().queryByColumnSelf(Selfserial.value);
      print('DDEdddddddd${dbListsf}');
      selfList.value  = dbListsf;

      // QR 스캔 탭
      List<MyNums> dbListsf2 = await DBHelper().queryByColumnQr(Qrserial.value);
      print('DDEdddddddd${dbListsf2}');
      qrList.value  = dbListsf2;

  }

}