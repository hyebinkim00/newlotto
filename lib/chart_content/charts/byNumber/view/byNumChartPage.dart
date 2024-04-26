import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/byNumChartController.dart';
import 'verticalchart.dart';

class ByNumChartPage extends GetView<NumChartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // 그림자를 제거
        centerTitle: true,
        title: Text(
          '번호별 통계',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            color: Colors.black,
            // 아이콘의 색상을 검정색으로 설정
            onPressed: () {
              Get.back();
            }),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => DropdownButton(
                      menuMaxHeight: 400,
                      value: '${controller.selectedStart}' ,
                      hint: Text('1'),
                      items: controller.startNum
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        controller.selectedStart.value = int.parse(value!);
                      })),
                  Text('~'),
                  Obx(
                    () => DropdownButton(
                        menuMaxHeight: 400,
                        value: '${controller.selectedEnd}',
                        hint: Text('0'),
                        items: controller.endNum
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          controller.selectedEnd.value = int.parse(value!);
                        }),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.chartTest();
                      },
                      child: Text('조회'))
                ],
              ),
              Expanded(
                  child: VerticalChart(
                controller: controller,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
