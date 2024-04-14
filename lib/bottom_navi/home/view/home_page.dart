import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/home/view/contents_home.dart';
import 'package:newlotto/bottom_navi/home/view/winnignums_home.dart';
import '../../../config/route_names.dart';
import '../../../notification.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
 // https://m.dhlottery.co.kr/gameResult.do?method=statByNumber&sttDrwNo=6&edDrwNo=1111
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
                              Text('이번주 로또발표날까지\n ${controller.days}일 남았습니다!',
                                  textAlign: TextAlign.center,
                                style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),),)
                      ),
                      // 맨위 박스 (날짜 + 당첨 번호 + 버튼 2개)
                      WinningNums(controller: controller),
                      Contents(),
                      // 저장기록 바로가기 추가해야됨
                    ],
                  ),
                ),
              )
          );
        } ,
      ),
    );
  }


}
