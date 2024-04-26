import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/home_contents/recent/view/oddeven_table_recent.dart';
import 'package:newlotto/home_contents/recent/view/pattern_table_recent.dart';

import '../../../ui/color_utils.dart';
import '../controller/recentanalysis_controller.dart';

class RecentAnalysisPage extends GetView<RecentAnalysisController> {
  //가장 많이 나온 숫자: 이전 로또 추첨 결과를 분석하여 가장 자주 나온 숫자들을 확인하는 것은 많은 사람들이 관심을 가지는 주제입니다. 특정 숫자가 자주 나온다는 사실은 해당 숫자를 선택하는 데 도움이 될 수 있다고 여겨질 수 있습니다.
  //
  // 가장 적게 나온 숫자: 반대로, 이전 추첨 결과에서 가장 적게 나온 숫자들을 확인하는 것도 중요합니다. 어떤 숫자가 오랫동안 나오지 않았다면 다음 번 추첨에서 나올 가능성이 높다고 여겨질 수 있습니다.
  //
  // 숫자의 연속성: 인접한 추첨 결과에서 숫자들 사이의 연속성을 분석하는 것도 중요합니다. 예를 들어, 최근에 1, 2, 3, 4, 5, 6과 같은 연속된 숫자가 나온다면 다음 추첨 결과에서는 이러한 패턴이 계속될지 여부에 대해 궁금증이 생길 수 있습니다.
  //
  // 짝수와 홀수 숫자의 분포: 추첨 결과에서 짝수와 홀수 숫자의 비율을 분석하는 것도 중요합니다. 예를 들어, 최근 추첨 결과에서 홀수 숫자가 더 많이 나왔다면 다음 추첨에서는 짝수 숫자가 나올 가능성이 높다고 여겨질 수 있습니다.
  //
  // 패턴 및 반복: 이전 추첨 결과에서 특정한 숫자 패턴이나 반복되는 숫자들을 확인하는 것도 중요합니다. 예를 들어, 특정한 숫자가 연속해서 나오거나 두 번 이상 나온 경우에는 해당 숫자를 선택하는 데 대한 고려가 필요합니다.


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // 그림자를 제거
        centerTitle: true,
        title: Text(
          '최근 당첨번호로 보는 확률',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            color: Colors.black,
            // 아이콘의 색상을 검정색으로 설정
            onPressed: () {
              Get.back();
            }),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          child:
          Column(
            children: [
              // 최근 5주 (5개)  db query 에 limit 주기
              // 최근 10주 (10개)
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(children: [
                      Text('가장 많이 나온 숫자'),
                      Obx(() => Text('${controller.mostNum}'+'('+'${controller.mostNumf}'+')'))
                    ],),
                    Row(children: [
                      Text('가장 적게 나온 숫자'), // 최근 5주, 최근 10주 는 아예 안나온 수가 맞는거 같음
                      Obx(() => Text('${controller.LeastNum}'+'('+'${controller.leastNumf}'+')'))
                    ],),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                child: Column(
                  children: [
                TabBar(
                  tabs: [Tab(text: '패턴으로 보기'),Tab(text:'홀짝으로 보기')],
                  controller: controller.tabController,
                  indicatorColor: Colors.deepOrangeAccent,
                  padding: EdgeInsets.all(10),
                  labelColor: Colors.black,
                  // indicator: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(
                  //     0xffffa228)),
                  unselectedLabelColor: Colors.grey,
                  onTap: (index){controller.currentIndex.value = index;},
                ),
                  ]
                ),
              ),
              Obx(() =>
              controller.currentIndex == 0 ? PatternTable(controller) : OddEvenTable(controller),
              )
            ],
          ),
        ),
      ),
    );
  }
}
