import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/noti_controller.dart';

class NotiPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GetBuilder<NotiController>(
        init:  NotiController(),
        builder: (controller) {
          return SafeArea(child: Container(child: Text('알림'),));
        },
      )
    );

  }
}
