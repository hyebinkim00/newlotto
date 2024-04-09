import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:newlotto/bottom_navi/record/controller/record_controller.dart';

class RecordPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  GetBuilder<RecordController>(
          init:  RecordController(),
          builder: (controller) {
            // 차트
            return SafeArea(
                top: true,
                child: Column(
                  children: [
                    Text('차트'),
                    // 번호 별 통계
                    // 구간별 통계
                    // 연속 번호 통계 할까말까

                  ],
                ));
          },
        )
    );  }
}
