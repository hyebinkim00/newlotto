import 'package:flutter/material.dart';

import '../../../mypage_list/record/purchase/view/purchase_page.dart';
import '../../../mypage_list/record/random/view/randomnums_page.dart';

class RecodeMenu extends StatelessWidget {

  final List<String> cardText = [
    '구입번호 당첨기록',
    '랜덤번호 생성기록',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Container(
              child: Text(
                '내가 저장한 번호 목록!',
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
                if (index == 0) {

                // 구입 ( QR , 직접 입력 저장 기록)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PurchasePage()),
                );
              }
              // 랜덤 번호 기록
              else if (index == 1){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RandomNumsPage()),
                );

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
        color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.7),
                      spreadRadius: 8,
                      blurRadius: 7,
                      offset: Offset(0, 2), // 그림자 위치 조정
                    ),
                  ],
                ),
                child: Text('${cardText[index]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)))),
      ),
    );
  }
}
