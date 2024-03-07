import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/route_names.dart';
import '../../ui/color_utils.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final List<String> cardText = ['행운의 번호', '랜덤생성', '번호 추첨기', '오늘의 운세'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller){
          return SafeArea(
            top: false,
              child:
              Container(
                height: Get.height, //double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:20),
                        child:
                          Obx(()=>
                              Text('이번주 로또발표날까지 ${controller.days}일 남았습니다!\nGood Luck!',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),)
                      ),
                      // 맨위 박스 (날짜 + 당첨 번호 + 버튼 2개)
                      Container(
                        width: screenWidth,
                        height: 300.h,
                        margin: EdgeInsets.all(10),
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // 오늘 날짜
                            Text(
                              controller.getDate(),
                              style: TextStyle(fontSize: 15),
                            ),
                            // 최신회차 당첨 번호
                            Obx(() => Text(
                                '${controller.lastSerial} 회 당첨 번호',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Obx(
                                  () => Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: List.generate(8, (index) {
                                    return Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorUtil.getColors(
                                              controller.lists[index]),
                                        ),
                                        child: Container(
                                            width: double.infinity,
                                            child: Center(
                                              child: Text(
                                                '${controller.lists[index]}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  // 텍스트 색상 설정
                                                  fontSize: 20.0, // 텍스트 크기 설정
                                                ),
                                              ),
                                            )),
                                      ),
                                    );
                                  },),
                                ),
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blueGrey),
                                      ),
                                      onPressed: () {
                                        // Get.offAndToNamed(RouteNames.SELF);
                                        Get.toNamed(RouteNames.SELF, arguments: {
                                          'lastSerial': controller.lastSerial
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround, // 수정
                                        children: [
                                          Icon(Icons.confirmation_number_outlined),
                                          Text(' 번호 직접 입력')
                                        ],
                                      )),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blueGrey),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(RouteNames.QRSACN);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround, // 수정
                                        children: [
                                          Icon(Icons.camera_alt_outlined),
                                          Text(' QR코드로 스캔')
                                        ],
                                      )),
                                ])
                          ],
                        ),
                      ),
                      // TopMainView(controller: controller,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                                '번호를 추천해드릴께요!',
                                style: TextStyle(fontSize: 15),
                              )),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // to disable GridView's scrolling
                            shrinkWrap: true,
                            // You won't see infinite size error
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  if(index==0){
                                    Get.toNamed(RouteNames.SPINNING);
                                  }if( index==1){
                                    Get.toNamed(RouteNames.RANDOM);
                                  }

                                  if (index == 3) {
                                    Get.toNamed(RouteNames.RECORDNUM,arguments: {
                                      'lastSerial': 1106
                                    });                                  }
                                  print('HBS::: $index');
                                },
                                child: myMenu(index),
                              );
                            },
                            itemCount: cardText.length,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
          );
        } ,
      ),
    );
  }

  Widget myMenu(int index) {
    return Container(
      child: Card(
        color: Colors.lightGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black12,
        child:
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add_circle),
              Text('${cardText[index]}', style: TextStyle(color: Colors.white)),
            ]),
      ),
    );
  }
}
