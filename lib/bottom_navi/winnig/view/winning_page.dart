import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/controller/noti_controller.dart';
import 'package:newlotto/bottom_navi/winnig/controller/winnig_controller.dart';
import 'package:newlotto/bottom_navi/winnig/view/result_winning.dart';
import 'package:newlotto/bottom_navi/winnig/view/search_winning.dart';
import 'package:newlotto/bottom_navi/winnig/view/table_winnig.dart';

import '../../../ui/color_utils.dart';

class WinningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: GetBuilder<WinningController>(
      init: WinningController(),
      builder: (controller) {
        // API로 가져오기
        return SafeArea(
            top: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '회차 별 당첨금',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SearchWinning(controller: controller),
                ResultWinning(controller: controller),
                TableWinning(controller: controller)
                // Obx(() => DataTable(
                //       columns: [
                //         DataColumn(label: Expanded(child: Text('순위'))),
                //         DataColumn(label: Expanded(child: Text('당첨게임 수'))),
                //         DataColumn(label: Expanded(child: Text('1게임당 당첨금액'))),
                //       ],
                //       rows: List<DataRow>.generate(
                //         controller.inlist2.length,
                //         (index) => DataRow(
                //           cells: [
                //             DataCell(Text('${index + 1}등')),
                //             DataCell(
                //                 Text('${controller.inlist2[index].people}')),
                //             DataCell(
                //                 Text('${controller.inlist2[index].money}')),
                //           ],
                //         ),
                //       ),
                //     )),
              ],
            ));
      },
    ));
  }
}
