

import 'package:newlotto/random2/controller/random2_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/util_dialog.dart';
import '../../model/event.dart';



// HomePage -> RandomPage

class RandomPage extends StatelessWidget {
  // 번호추첨 -> 제외 하고 싶은 숫자 , 포함하고 싶은 숫자  , ---> 여섯개 숫자 랜덤 리스트 10개 == > 생성된 번호 저장 가능
  TextEditingController _controller = TextEditingController();

  List<int> ss = [4, 9];
  bool press = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Random2Controller>(
          init: Random2Controller(),
          builder: (controller) {
            return SafeArea(
              top: true,
              child: Container(
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TableCalendar(
                        locale: 'ko_KR',
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month'
                        },
                      calendarStyle: CalendarStyle(
                        markerSize: 10.0,
                        markerDecoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                        ),
                      ),
                       eventLoader: (day) {
                          if (day.weekday == DateTime.saturday){
                            return [Event('DAY!')];
                          }
                          return [];
                       } ,

                    ),
                    Text('로또 번호를 만들어 드릴께요! \n포함하고 싶은 숫자와 제외하고 싶은 숫자를 선택해 주세요.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // 테두리 색상
                          width: 2, // 테두리 두께
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('포함 하고 싶은 숫자'),
                          Row(
                            children: [
                              Text('data',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                  onPressed: () {
                                    // _showNumberInputDialog(context);
                                    UtilDialog.getDi(context);
                                    // UtilDialog.selectNumbers(context, false,controller.sel.value,(select){
                                    //   print('selelel+_${select}');
                                    //   controller.onSele(select);
                                    // } );
                                  },
                                  child: Text('초기화')),
                              TextButton(
                                  onPressed: () {
                                    // _showNumberInputDialog(context);
                                    UtilDialog.getDi(context);
                                    // UtilDialog.selectNumbers(context, false,controller.sel.value,(select){
                                    //   print('selelel+_${select}');
                                    //   controller.onSele(select);
                                    // } );
                                  },
                                  child: Text('추가')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Obx(
                    //   () => Text('SSS__${controller.s.value}'),
                    // ),
                    Obx(() => Text('SSS__${controller.includeList.value}')),
                    // Obx(
                    //   () => ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: controller.allRandomNumbers.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Center(
                    //         child: Text('${controller.allRandomNumbers[index]}'),
                    //       );
                    //     },
                    //   ),
                    // ),
                    TextButton(
                        onPressed: () {
                          press = !press;
                          controller.onTap();
                        },
                        child: Text('번호 생성하기')),
                    // Obx(() => AnimatedSwitcher(
                    //     duration: Duration(milliseconds: 1000),
                    //   child: createBox(controller.isSwitched.value),
                    //   transitionBuilder : (Widget child, Animation<double> animation) {
                    //     return FadeTransition(
                    //       opacity: animation,
                    //       child: child,
                    //     );
                    //   },
                    // )),
                    // Obx(() => TweenAnimationBuilder(
                    //   duration: Duration(milliseconds: 2000),
                    //   curve: Curves.easeInOut, // 추가된 부분
                    //   tween: Tween<double>(begin: 0, end: controller.angle.value),
                    //   onEnd: (){controller.onTap3();} ,
                    //   builder: (BuildContext con, double val, child) {
                    //     return Transform(
                    //         alignment: Alignment.center,
                    //       // alignment: FractionalOffset.center,
                    //       transform:Matrix4.identity()
                    //         ..setEntry(3, 2, 0.002) // 원근 효과
                    //         ..rotateY(val * (3.14 / 180)),
                    //       child: Container(width: 100, height: 100,
                    //         decoration:BoxDecoration(
                    //           color: controller.isBack.value ? Colors.black: Colors.yellowAccent,
                    //           borderRadius: BorderRadius.all(Radius.circular(10.0)
                    //           ),
                    //         ),
                    //         child: (Center(child:Text(controller.isBack.value?'Front':'Back'))),
                    //       ),
                    //     );
                    //   },
                    // )),
                    // // 이걸 써야겟다 ( 눌렀을때 번호 공개)
                    // Obx(() => GestureDetector(
                    //   onTap: (){controller.onTap2();},
                    //   child: AnimatedContainer(
                    //     duration: Duration(milliseconds: 500),
                    //     curve: Curves.easeInOut,
                    //     transform: Matrix4.rotationY(controller.angle.value * (3.1415927 / 180)),
                    //     width: 100,
                    //     height: 100,
                    //     decoration: BoxDecoration(
                    //       color: controller.backgroundColor.value,
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         controller.isBack.value ? '' : 'Front',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),),
                    // ))
                  ],
                ),
              ),
            );
          }),
    );
  }

  ///https://iosroid.tistory.com/8

  Widget wrapAnimatedBuilder(Widget widget, Animation<double> animation) {
    final rotate = Tween(begin: pi, end: 0.0).animate(animation);

    return AnimatedBuilder(
      animation: rotate,
      child: widget,
      builder: (_, widget) {
        return Transform(
          transform: Matrix4.rotationY(rotate.value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
