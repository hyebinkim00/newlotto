import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:newlotto/bottom_navi/record/record_controller.dart';

class RecordPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  GetBuilder<RecordController>(
          init:  RecordController(),
          builder: (controller) {
            return SafeArea(child: Container(child: Text(' 당첨기록 / 번호기록 '),));
          },
        )
    );  }
}
