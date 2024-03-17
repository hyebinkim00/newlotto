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
            // 회차
            Row(
              children: [
                Icon(Icons.lefe)
              ],
            ),
            Obx(() => DataTable(
                  columns: [
                    DataColumn(label: Text('순위')),
                    DataColumn(label: Text('당첨게임 수')),
                    DataColumn(label: Text('1게임당 당첨금액')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('${controller.inlist[0].people}')),
                      DataCell(Text('people')),
                      DataCell(Text('money')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(Text('people')),
                      DataCell(Text('money')),
                    ])
                  ],
                )),
          ],
        ));
      },
    ));
  }
}
