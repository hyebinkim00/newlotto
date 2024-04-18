import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controller/byNumChartController.dart';
import 'verticalchart.dart';

class ByNumChartPage extends GetView<NumChartController>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                  DropdownButton(
                      menuMaxHeight: 400,
                      hint: Text('0'),
                      items: controller
                          .startNum
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                      }),
                  Text('~'),
                  DropdownButton(
                      menuMaxHeight: 400,
                      hint: Text('0'),
                      items: controller
                          .endNum
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                      }),
                  TextButton(onPressed: (){
                    controller.chartTest();
                  }, child: Text('조회'))

                ],
              ),
              Expanded(child: VerticalChart(controller: controller,))
            ],
          ),

        ) ,

      ),
    );
  }


}