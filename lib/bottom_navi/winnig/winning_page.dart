import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/noti_controller.dart';
import 'package:newlotto/bottom_navi/winnig/winnig_controller.dart';

class WinningPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<WinningController>(
      init: WinningController(),
      builder: (controller) {
        // API로 가져오기
        return SafeArea(
          top: true,
            child: Column(
          children: [
            Text('회차 별 당첨금'),
            // 회차
            // Row(
            //   children: [
            //     Icon(Icons)
            //   ],
            // ),,
            DropdownButton(
              hint:
                  Obx(()=>Text('${controller.s}'),),
                items: controller.getDropdownItems().map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
                onChanged: (String? value){
              controller.changeValue(value!);
                }),
            Obx(() => DataTable(
                  columns: [
                    DataColumn(label: Expanded(child: Text('순위'))),
                    DataColumn(label: Expanded(child: Text('당첨게임 수'))),
                    DataColumn(label: Expanded(child: Text('1게임당 당첨금액'))),
                  ],
              rows: List<DataRow>.generate(
                controller.inlist2.length,
                    (index) => DataRow(
                  cells: [
                    DataCell(Text('${index + 1}등')),
                    DataCell(Text('${controller.inlist2[index].people}')),
                    DataCell(Text('${controller.inlist2[index].money}')),
                  ],
                ),
              ),
                )),
          ],
        ));
      },
    ));
  }
}
