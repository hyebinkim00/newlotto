import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/winnig_controller.dart';

class SearchWinning extends StatelessWidget {
  WinningController controller;

  SearchWinning({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton(
            menuMaxHeight: 400,
            hint: Obx(
                  () => Text('${controller.serial}'),
            ),
            items: controller
                .items
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              controller.changeValue(value!);
            }),
        Text('회'),
        SizedBox(width: 10,),
        TextButton(style : ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
            onPressed: () {controller.getWebResult(controller.serial.value);},
            child: Text('조회', style: TextStyle(color: Colors.white),))
      ],
    );
  }
}
