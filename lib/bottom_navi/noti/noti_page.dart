import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/noti_controller.dart';

class NotiPage extends StatelessWidget {
  List<List<String>> data = [
    ['등위', '당첨방법', '당첨금의 배분 비율'],
    ['1등', '6개 번호 일치', '총 당첨금 중 4등, 5등 금액을 제외한 금액의 75%'],
    ['2등', '5개 번호 일치\n+ 보너스 번호 일치', '총 당첨금 중 4등, 5등 금액을 제외한 금액의 12.5%'],
    ['3등', '5개 번호 일치', '총 당첨금 중 4등, 5등 금액을 제외한 금액의 12.5%'],
    ['4등', '4개 번호 일치', '5,0000원'],
    ['5등', '3개 번호 일치', '5,000원']
  ];

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
            child: SingleChildScrollView(
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
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        children: [
                          Table(
                              columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(4)
                              },
                              defaultColumnWidth: IntrinsicColumnWidth(),
                           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              border: TableBorder.all(width: 1.0),
                              children: List.generate(
                                data.length,
                                    (index) => TableRow(
                                  children: List.generate(
                                    data[index].length,
                                        (subIndex) => TableCell(
                                          child: Container(
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                data[index][subIndex],
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                              ),),
                          SizedBox(height: 20),
                          Text('총 당첨금은 로또 전체 판매액의 50%'),
                          Text('1, 2, 3등 당첨금은 해당 회차의 총 판매액에 의해 결정되며, 등위별 해당금액을 당첨자 수로 나누어 지급합니다.')
                        ],
                      ),
                    ),
                    SizedBox(height: 10,)
                  ]),
              ExpansionTile(
                iconColor: Colors.black,
                title: new Text(
                  '로또 추첨 방송',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * (16 / 360),
                      color: Colors.black),
                ),
                initiallyExpanded: false,
                backgroundColor: Colors.white,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text('로또 6/45의 추첨방송은 매주 토요일 오후 8시 35분경 MBC방송국 스튜디오에서 생방송으로 진행되며, 추첨을 통해 당첨번호가 결정되고 그 결과를 확인하실 수 있습니다.\n'
                        ' (주)동행복권과 MBC의 추첨방송 담당자, 경찰관, 방청객들이 지켜보는 가운데 공정하고 투명한 절차를 거쳐 진행됩니다.'),
                  )
                ]
              ),
              ExpansionTile(
                  iconColor: Colors.black,
                  title: new Text(
                    '로또 구입 안내',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * (16 / 360),
                        color: Colors.black),
                  ),
                  initiallyExpanded: false,
                  backgroundColor: Colors.white,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          Expanded(child: Text('로또 6/45는 (주)동행복권과 판매점 계약을 체결한 로또 단말기가 설치된 판매점(전국의 편의점, 복권방 및 가판대 등)뿐만 아니라,(주)동행복권 공식홈페이지에서 구매가 가능하여 편리합니다.',softWrap: true,    textAlign: TextAlign.center,)),
                          // Text('매일 6시부터 24시까지 1년 365일 연중무휴 판매합니다.'),
                          // Text('추첨일(토요일)에는 오후 8시에 판매 마감합니다.'),
                          // Text('추첨일 오후 8시부터 다음날(일요일) 오전 6시까지는 판매가 정지됩니다.'),
                          // Text('만 19세 미만 청소년은 복권 및 복권기금법에 따라 복권을 구매할 수 없습니다.')
                        ],
                      ),
                    )
                  ]
              ),
              ExpansionTile(
                  iconColor: Colors.black,
                  title: new Text(
                    '로또 추첨 방송',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * (16 / 360),
                        color: Colors.black),
                  ),
                  initiallyExpanded: false,
                  backgroundColor: Colors.white,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5,left: 5),
                      child: Text('로또 6/45의 추첨방송은 매주 토요일 오후 8시 35분경 MBC방송국 스튜디오에서 생방송으로 진행되며, 추첨을 통해 당첨번호가 결정되고 그 결과를 확인하실 수 있습니다.\n'
                          ' (주)동행복권과 MBC의 추첨방송 담당자, 경찰관, 방청객들이 지켜보는 가운데 공정하고 투명한 절차를 거쳐 진행됩니다.'),
                    )
                  ]
              )
          ],
        ),
            ));
      },
    ));
  }
}
