import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/winnig/controller/winnig_controller.dart';

class TableWinning extends StatelessWidget {
  final WinningController controller;

  TableWinning({required this.controller});

  @override
  Widget build(BuildContext context) {
    return DataTable(
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
            DataCell(Obx(() => Text('${controller.inlist2[index].people}'))),
            DataCell(Obx(() => Text('${controller.inlist2[index].money}'))),
          ],
        ),
      ),
    );
  }
}
