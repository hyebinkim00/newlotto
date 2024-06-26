import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../config/route_names.dart';
import '../../../notification.dart';

class Contents extends StatelessWidget {
  final List<String> cardText = [
    '랜덤 번호 만들기',
    '최근당첨번호\n확률분석',
    '생일로 보는\n오늘의 번호',
    '돌림판으로 보는\n오늘의 번호',
  ];
  List<IconData> iconDataList = [
    Icons.format_list_numbered,
    Icons.calendar_today_outlined,
    Icons.person_pin,
    Icons.play_circle_rounded
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
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
                switch (index) {
                  case 0:
                    // 랜덤 리스트 (완성)
                    Get.toNamed(RouteNames.RANDOM);
                    break;
                  case 1:
                    // 최근 당첨번호 확률로 보는 번호
                    Get.toNamed(RouteNames.RECENT);
                    break;
                  case 2:
                    // 생일로 보는 오늘의 번호
                    Get.toNamed(RouteNames.BIRTHDAY);
                    break;
                  case 3:
                  // 돌림판으로 뽑는 오늘의 번호
                    Get.toNamed(RouteNames.SPINNING);
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
        color: Color(0xE7DEFF8B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    // BoxShadow(
                    //   color: Colors.white.withOpacity(0.7),
                    //   spreadRadius: 8,
                    //   blurRadius: 7,
                    //   offset: Offset(0, 2), // 그림자 위치 조정
                    // ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(iconDataList[index]),
                    Text('${cardText[index]}',
                        textAlign: TextAlign.center
                        ,style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ],
                ))),
      ),
    );
  }
}
