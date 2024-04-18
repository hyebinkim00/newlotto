import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../config/route_names.dart';
import '../../../notification.dart';

class Contents extends StatelessWidget {

  final List<String> cardText = ['로또번호 랜덤생성', '돌림판으로 뽑아보는\n오늘의 번호','생일로 보는\n오늘의 번호', '최근당첨번호\n확률분석'];
  List<IconData> iconDataList = [
    Icons.play_circle_rounded,
    Icons.remove_circle,
    Icons.edit, Icons.edit];

  @override
  Widget build(BuildContext context) {
    return
      Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Container(
              child: Text(
                '번호를 추천해드릴께요!',
                style: TextStyle(fontSize: 20),
              )),
        ),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          // to disable GridView's scrolling
          shrinkWrap: true,
          // You won't see infinite size error
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.5, // 가로:세로 비율 설정
              crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {

                switch(index){
                  case 0 :
                    // 랜덤 리스트
                    Get.toNamed(RouteNames.RANDOM);
                    break;
                  case 1 :
                    // 돌림판
                    Get.toNamed(RouteNames.SPINNING);
                    break;
                  case 2 :
                    // 생일 입력 받기
                    Get.toNamed(RouteNames.BIRTHDAY);
                    break;
                  case 3 :
                    Get.toNamed(RouteNames.RECENT);
                    break;

                }
                //
                // await Future.delayed(Duration(seconds: 1)); // 1초간 기다립니다.
                // FlutterLocalNotification.showNotification();
              },
              child: myMenu(index),
            );
          },
          itemCount: cardText.length,
        ),
      ],
    );
  }

  Widget myMenu(int index) {
    return Container(
      width: 30,
      height: 30,
      child: Card(
        color: Colors.tealAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
        child:
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon(Icons.add_circle),
              Text('${cardText[index]}', style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500)),
            ]),
      ),
    );
  }
}
