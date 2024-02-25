import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../model/numInfo.dart';
import '../../model/selfnum.dart';
import '../controller/mypage_controller.dart';

class MyPage extends StatelessWidget {
  List<numInfo>? numBox = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('저장 목록'),
        ),
        body: GetBuilder<MyPageController>(
          init: MyPageController(),
          builder: (controller) {
            return SafeArea(
              top: false,
                child:
                Column(
                  children: [
                    TabBar(tabs: [Tab(text: '직접입력'),Tab(text:'QR스캔')],
                      controller: controller.tabController,
                      indicatorColor: Colors.deepOrangeAccent,
                      padding: EdgeInsets.all(10),
                      labelColor: Colors.black,
                      // indicator: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(
                      //     0xffffa228)),
                      unselectedLabelColor: Colors.grey,
                      onTap: (index){controller.currentIndex.value = index;},
                    ),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.serialMinus();
                              },
                              icon: Icon(Icons.arrow_circle_left)),
                          Text(
                            controller.currentIndex.value == 0
                                ? '${controller.Selfserial}'
                                : '${controller.Qrserial}',
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.serialPlus();
                              },
                              icon: Icon(Icons.arrow_circle_right))
                        ],
                      )),
                    Expanded(
                      child: TabBarView(
                          controller: controller.tabController,
                          children: tabViweList(controller)),
                    )

                  ],
                ),
            );
          }
        ));
  }

  List<Widget> tabViweList(MyPageController controller) {
    return [
      Center(
        child: Container(child: Obx(() =>
            ListView.builder(
                itemCount: controller.dblist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Column(children: [
                      Text(('${controller.dblist[index].serial}')), // 회차
                      FutureBuilder(
                          future: controller.getResults(controller.dblist[index]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // return CircularProgressIndicator();// 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
                              return Container(
                                color: Colors.transparent,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData) {
                              return Text(
                                  'No data available'); // 데이터가 없는 경우에 대한 처리를 추가합니다.
                            } else if (snapshot.data != null &&
                                snapshot.hasData) {
                              numBox = snapshot.data;
                            }
                            return Container(
                              color: Colors.grey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: List.generate(snapshot.data!.length,
                                        (indexs) {
                                      return Expanded(
                                        child: Container(
                                          width: 50.0,
                                          height: 50.0,
                                          margin: EdgeInsets.only(
                                              left: 5, right: 5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: snapshot.data![indexs].color,
                                          ),
                                          child: Center(
                                              child: Text(
                                                '${snapshot.data![indexs]
                                                    .number}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  // 텍스트 색상 설정
                                                  fontSize: 24.0, // 텍스트 크기 설정
                                                ),
                                              )),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          })
                    ]),
                  );
                })),),
      ),
      Center(
        child:  Container(
          child: Obx(()=>
          // DB 에 저장되어 있는 QR정보들 리스트
          ListView.builder(
            itemCount: controller.qrtest.length, // 예제로 5개의 항목을 만듭니다.
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1.0)
                ),
                height: 150, // 각 항목의 높이를 설정합니다.
                // 정보 한개씩 박스 안에 표시
                child: Column(
                  children: [
                    Text('${controller.qrtest[index].serial}'),
                    FutureBuilder(
                      // controller.qrtest 안에 serial , List<QRInfo> 리스트 (DB 리스트)
                        future: controller.getTEST(1102,controller.qrtest[index].myNum??[]),
                        builder: (context,snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // return CircularProgressIndicator();// 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
                            return Container(color: Colors.transparent,);
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return Text('No data available'); // 데이터가 없는 경우에 대한 처리를 추가합니다.
                          }
                          else if (snapshot.data != null && snapshot.hasData) {
                            print('SSSSBBB${snapshot.data}');

                            //controller.QRballLists.value = snapshot.data!;
                          }
                          return Expanded(
                            // 세로 리스트 (NumInfo 갯수)
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return  Container(
                                  width: 200.0,
                                  height: 50.0,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal, // 가로 방향으로 스크롤합니다.
                                    itemCount: snapshot.data![index].length,
                                    itemBuilder: (BuildContext context , int indexs){
                                      return Container(
                                        width: 30.0,
                                        height: 50.0,
                                        margin: EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: snapshot.data![index][indexs].color,
                                        ),
                                        child: Center(
                                            child: Text(
                                              '${snapshot.data![index][indexs].number}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                // 텍스트 색상 설정
                                                fontSize: 24.0, // 텍스트 크기 설정
                                              ),
                                            )),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ],
                ),
              );
            },
          )),
        ),
      )
    ];
  }

}
