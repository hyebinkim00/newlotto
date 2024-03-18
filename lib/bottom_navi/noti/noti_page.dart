import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/noti_controller.dart';

class NotiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<NotiController>(
          init: NotiController(),
          builder: (controller) {
            double screenWidth = MediaQuery.of(context).size.width;
            double screenHeight = MediaQuery.of(context).size.height;

            // 로또 규칙
            // 앱 사용법

            return SafeArea(
                child: Column(
                  children: [
                    ExpansionTile(
                        iconColor: Colors.black,
                        title: new Text(
                          '당첨금 규칙',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * (16 / 360),
                              color: Colors.black),
                        ),
                        initiallyExpanded: true,
                        backgroundColor: Colors.white,
                        children: <Widget>[
                          Container(
                            // height: screenHeight * 0.05,
                            width: screenWidth,
                            child: Column(
                              children: [
                                Table(

                                    // columnWidths: {
                                    //   0: FixedColumnWidth(100.0),// fixed to 100 width
                                    //   1: FlexColumnWidth(),
                                    //   2: FixedColumnWidth(100.0),//fixed to 100 width
                                    // },
                                    defaultColumnWidth: IntrinsicColumnWidth(),
                                    border:  TableBorder.all(width: 1.0),
                                    children: [
                                  TableRow(children: [
                                    Text('등위'),
                                    Text('당첨방법'),
                                    Text('당첨금의 배분 비율')
                                  ]),
                                  TableRow(children: [
                                    Text('1등'),
                                    Text('6개 번호 일치'),
                                    Text('총 당첨금 중 \n4등, 5등 금액을 제외한 금액의 75%'),
                                  ]),
                                  TableRow(children: [
                                    Text('2등'),
                                    Text('5개 번호 일치 \n +보너스 번호 일치'),
                                    Text('총 당첨금 중 4등, 5등 금액을 제외한 금액의 12.5%'),
                                  ]),
                                  TableRow(children: [
                                    Text('3등'),
                                    Text('5개 번호 일치'),
                                    Text('총 당첨금 중 \n4등, 5등 금액을 제외한 금액의 12.5%'),
                                  ]),
                                  TableRow(children: [
                                    Text('4등'),
                                    Text('4개 번호 일치'),
                                    Text('5,0000d원'),
                                  ]),
                                  TableRow(children: [
                                    Text('5등'),
                                    Text('3개 번호 일치'),
                                    Text('5,000원')
                                  ])
                                ]),
                                Text('총 당첨금은 로또 전체 판매액의 50%'),
                                Text('1, 2, 3등 당첨금은 해당 회차의 총 판매액에 의해 결정되며, 등위별 해당금액을 당첨자 수로 나누어 지급합니다.')
                              ],
                            ),
                          ),
                          Divider(height: 3, color: Colors.black),
                          Container(
                            height: screenHeight * 0.05,
                            width: screenWidth,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.0444444),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.24444,
                                    child: Text(
                                      '기존 보증금',
                                      style: TextStyle(
                                        fontSize: screenWidth * (16 / 360),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '234만원',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenWidth * (16 / 360),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 3,
                            color: Colors.black,
                          ),
                          Container(
                            height: screenHeight * 0.05,
                            width: screenWidth,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.0444444),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.24444,
                                    child: Text(
                                      '평균 공과금',
                                      style: TextStyle(
                                        fontSize: screenWidth * (16 / 360),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '234만원',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenWidth * (16 / 360),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ],
                ));
          },
        ));
  }
}
