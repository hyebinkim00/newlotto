import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/byColorController.dart';
import 'PiechartPage.dart';


class ByColorChartPage extends GetView <byColorController> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('색상별 통계'),),
      body: SafeArea(
        top: true,
        child: Container(
          height: double.infinity,
          child: Column(
            children: [

              Obx(() => Text('${controller.test}')),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Obx(() =>      DropdownButton(
                      menuMaxHeight: 400,
                      hint: Text('${controller.seleNum}'),
                      items: controller
                          .startNum
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        controller.seleNum.value = int.parse(value!);
                      }),),
                  Text('~'),
                Obx(() =>   DropdownButton(
                    menuMaxHeight: 400,
                    hint: Text('${controller.sele2Num}'),
                    items: controller
                        .endNum
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      controller.sele2Num.value = int.parse(value!);
                    }),),
                  TextButton(onPressed: (){
                    controller.chartTest();

                  }, child: Text('조회'))

                ],
              ),
              // WebViewWidget(controller: controller.webViewController),
              Expanded(child: PieChartSample2()),
            ],
          ),
        ),),
    );
  }

}