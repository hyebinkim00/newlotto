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
            // ),
            Obx(() => DataTable(
                  columns: [
                    DataColumn(label: Text('순위')),
                    DataColumn(label: Text('당첨게임 수')),
                    DataColumn(label: Text('1게임당 당첨금액')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('1등')),
                      DataCell(Text('${controller.inlist[0].people}')),
                      DataCell(Text('${controller.inlist[0].money}')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2등')),
                      DataCell(Text('${controller.inlist[1].people}')),
                      DataCell(Text('${controller.inlist[1].money}')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('3등')),
                      DataCell(Text('${controller.inlist[2].people}')),
                      DataCell(Text('${controller.inlist[2].money}')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('4등')),
                      DataCell(Text('${controller.inlist[3].people}')),
                      DataCell(Text('${controller.inlist[3].money}')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('5등')),
                      DataCell(Text('${controller.inlist[4].people}')),
                      DataCell(Text('${controller.inlist[4].money}')),
                    ])
                  ],
                )),
          ],
        ));
      },
    ));
  }
}
