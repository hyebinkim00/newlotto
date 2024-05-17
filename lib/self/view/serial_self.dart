import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/self/controller/self_controller.dart';

import '../../ui/dialog_utils.dart';

class SerialSelection extends StatelessWidget {
  late SelfController controller;

  SerialSelection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.only(left: 10 ,right: 10),
          color: Colors.orangeAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(
                    '제 ${controller.btnText}회',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
              OutlinedButton(
                  onPressed: () {
                    DialogUtils.selectSerial(context, controller);
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 2, color: Colors.white), // 테두리 설정
                  ),
                  child: Text(
                    '회차 변경',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
