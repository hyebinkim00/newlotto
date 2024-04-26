import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/byColorController.dart';
import 'PiechartPage2.dart';

class ByColorChartPage extends GetView<byColorController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('색상별 통계'),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              Obx(() => Text('${controller.test}')),
              Container(
                color: Colors.grey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => DropdownButton(
                          menuMaxHeight: 400,
                          hint: Text('${controller.selectedStart}'),
                          value: '${controller.selectedStart}' ,
                          items: controller.startNum
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            controller.selectedStart.value = int.parse(value!);
                          }),
                    ),
                    Text('~'),
                    Obx(
                      () => DropdownButton(
                          menuMaxHeight: 400,
                          hint: Text('${controller.selectedEnd}'),
                          value: '${controller.selectedEnd}',
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
              ),
              // WebViewWidget(controller: controller.webViewController),
              Expanded(
                  child: PieChartSample(
                controller,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
