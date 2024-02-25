import 'dart:convert';

import 'newNum.dart';

class qrInfo{
  String? serial;
  List<newNum>? myNum;

  qrInfo({this.serial, this.myNum});

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'myNum':  jsonEncode(myNum!.map((numInfo) => numInfo.toMap()).toList()),
    };
  }

  factory qrInfo.fromMap(Map<String, dynamic> map) {
    return qrInfo(
      serial: map['serial'],
      myNum: (jsonDecode(map['myNum']) as List).map((e) => newNum.fromMap(e)).toList(),
    );
  }
}

