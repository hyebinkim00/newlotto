import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:newlotto/chart_content/charts/byPick/controller/byPickContoller.dart';

import '../../../../config/util_dialog.dart';

class PickChartPage extends GetView<byPickController> {
  @override
  Widget build(BuildContext context) {
    // TODO:  입력한 번호 에 대한 확률

    return Scaffold(
      body: SafeArea(
          top: true,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        6,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              dialog(context,controller);
                            },
                            child: Container(
                              width: 50, // 고정된 너비
                              height: 50, // 고정된 높이
                              padding: EdgeInsets.all(1),
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.orange,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${String.fromCharCode(controller.selec[index])}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arial',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  })),
              TextButton(onPressed: () {}, child: Text('입력')),
              Obx(() =>Text('메소드 1 _ ${controller.met1}'),),
              Obx(() =>Text('메소드 2 _ ${controller.met2}'),)
              // Animation 공 번호 입력
            ],
          )),
    );
  }
}


// 하나씩 입력받을까 한번에 할까


void dialog(BuildContext context, byPickController controller) {
  List<int> ll = [];
  int seleIndex = 0;
  String seleNum = '';


  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Numbers'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                int number = index + 1;
                bool isSel = ll.contains(number);
                return NumberBall2(
                  num: number,
                  isSelected: isSel,
                  onSelect: (isSelected) {
                    // 아이템이 선택될 때 처리
                    if(isSelected){
                      ll.add(number);
                      seleNum = number.toString();
                    }
                    print('Number $number is selected: $isSelected');
                  },
                );
              },
              itemCount: 45,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                controller.selec.value = ll;
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      });
}
