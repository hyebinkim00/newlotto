import 'package:flutter/material.dart';

class qrScan{
  String? serial;
  String? date;
  List<NumData>? winnerList;
  String? notice;
  //List<List<NumData>>? myNumList;

  List<myNums>? test; // 고른 번호 리스트
  qrScan({this.serial,this.date,this.winnerList,this.notice,this.test});
}

class myNums{
  List<NumData>? lists;
  String? results;
  myNums({this.lists,this.results});
}

class NumData{
  String? number;
  Color? color;

  NumData({
    this.number,
    this.color});
}