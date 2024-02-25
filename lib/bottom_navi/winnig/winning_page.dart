import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/noti_controller.dart';
import 'package:newlotto/bottom_navi/winnig/winnig_controller.dart';

class WinningPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GetBuilder<WinningController>(
        init:  WinningController(),
        builder: (controller) {
          return SafeArea(child: Container(child: Text('당첨번호 목록'),));
        },
      )
    );

  }
}
