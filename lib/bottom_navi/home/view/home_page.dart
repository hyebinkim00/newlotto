import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/home/view/home_contain.dart';

import '../../../config/route_names.dart';
import '../../../notification.dart';
import '../../../random2/controller/random2_controller.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  final List<String> cardText = ['행운의 번호', '랜덤생성', '번호 추첨기', '오늘의 운세'];
  List<IconData> iconDataList = [
    Icons.play_circle_rounded,
    Icons.remove_circle,
    Icons.edit, Icons.edit];

  // 확률 , 차트 (로또 분석)
  // 생일에 따른 번호 (Random)
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
                              Text('이번주 로또발표날까지 ${controller.days}일 남았습니다!\nGood Luck!',
                                  textAlign: TextAlign.center,
                                style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),)
                      ),
                      // 맨위 박스 (날짜 + 당첨 번호 + 버튼 2개)
                      HomeContainer(controller: controller),
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
                                    // Get.to(Random2Page());
                                    Get.put<Random2Controller>(Random2Controller());
                                    Get.toNamed(RouteNames.RANDOM);
                                    // Get.toNamed(RouteNames.RANDOM,arguments: {'g':'g'});
                                  }
                                  if (index == 3) {
                                    FlutterLocalNotification.showNotification();

                                    // Get.toNamed(RouteNames.RECORDNUM,arguments: {
                                    //   'lastSerial': 1106
                                    // });

                                  }
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
