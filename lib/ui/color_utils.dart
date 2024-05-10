import 'package:flutter/material.dart';

class ColorUtil{
  static Color yell = Color(0xffffb600);


  static Color getColors(String nums){
    if(nums=='+'){
      return Colors.transparent;
    }
    int num = int.parse(nums);
    if (1 <= num && num <= 10) {
      return ColorUtil.yell;
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





}
