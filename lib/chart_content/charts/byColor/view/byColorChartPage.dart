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
              Text('data'),
              // WebViewWidget(controller: controller.webViewController),
              Obx(() => Text('${controller.test}')),
              Expanded(child: PieChartSample2()),
            ],
          ),
        ),),
    );
  }

}