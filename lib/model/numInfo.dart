import 'dart:ui';

class numInfo {
  late Color? color;
  late int? number;

  numInfo({this.color, this.number});


  @override
  String toString() {
    return 'numInfo{color: $color, number: $number}';
  }
}