import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:random_text_reveal/random_text_reveal.dart';

import 'circlespin_controller.dart';

class CircleSpinPage extends GetView<CircleSpinController> {
  //
  // StreamController<int> streamController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // 그림자를 제거
        centerTitle: true,
        title: Text(
          '돌림판 게임',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '행운의 번호를 뽑아라!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              '물음표 공모양을 눌러 돌림판을 돌려보세요!',
              style: TextStyle(fontSize: 20),
            ),
            Obx(
              () => RandomTextReveal(
                key: controller.globalKey,
                initialText: '오늘 행운의 숫자는 ?',
                shouldPlayOnStart: false,
                text:
                    '숫자는 ${controller.randomVl.value} ${controller.randomV2.value} 입니다.',
                duration: const Duration(seconds: 3),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
                randomString: '123455678910',
                onFinished: () {},
                curve: Curves.easeIn,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _showFortuneWheelDialog(true);
                  },
                  child: Container(
                      width: 50.0,
                      height: 50.0,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Obx(
                        () => Center(
                            child: Text(
                          controller.randomVl.value,
                          style: TextStyle(
                            color: Colors.white, // 텍스트 색상 설정
                            fontSize: 24.0, // 텍스트 크기 설정
                          ),
                        )),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.randomVl.value == '?') {
                      Fluttertoast.showToast(msg: '십의자리 숫자부터 뽑아주세요.');
                      return;
                    }
                    _showFortuneWheelDialog(false);
                  },
                  child: Container(
                      width: 50.0,
                      height: 50.0,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Obx(
                        () => Center(
                            child: Text(
                          controller.randomV2.value,
                          style: TextStyle(
                            color: Colors.white, // 텍스트 색상 설정
                            fontSize: 24.0, // 텍스트 크기 설정
                          ),
                        )),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showFortuneWheelDialog(bool frontFlag) {
  // 0 ~ 45
  // 일의 자리 0 이면 ( 1~9 )
  // 일의자리 1~ 3 이면 ( 0~9 )
  // 일의자리 4 이면 ( 0~5 )

  CircleSpinController controller = Get.find<CircleSpinController>();

  late int value;
  late String resultNum = '';
  final StreamController<int> streamController = StreamController<int>();

  // 일의 자리
  List<int> nu = circleRan.frontNums;
  List<FortuneItem> itemss = circleRan.frontNumsItems;

  Get.dialog(AlertDialog(
    content: Expanded(
      // Adjust the height as needed
      child: Column(
        children: [
          SizedBox(
            width: 400,
            height: 400,
            child: FortuneWheel(
              indicators: <FortuneIndicator>[
                FortuneIndicator(
                  alignment: Alignment.topCenter,
                  // <-- changing the position of the indicator
                  child: TriangleIndicator(
                    color: Colors
                        .yellow, // <-- changing the color of the indicator
                  ),
                ),
              ],
              selected: streamController.stream,
              animateFirst: false,
              duration: const Duration(seconds: 3),
              items: frontFlag
                  ? itemss
                  : getItem(int.parse(controller.randomVl.value)),
              onAnimationEnd: () {
                if (frontFlag) {
                  resultNum = nu[value].toString();
                } else {
                  nu = getList(int.parse(controller.randomVl.value));
                  resultNum = nu[value].toString();
                }
                print('Dialogss+${nu[value]}');
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      value = frontFlag
                          ? Fortune.randomInt(0, 4)
                          : forRandom(int.parse(controller.randomVl.value));
                      streamController.add(value);
                    },
                    child: Text(resultNum == '' ? '시작' : '다시하기')),
                TextButton(
                    onPressed: () {
                      if (resultNum == '') {
                        Fluttertoast.showToast(msg: '시작 버튼을 눌러 돌림판을 돌려주세요!');
                      } else {
                        Get.back(result: resultNum);
                      }
                    },
                    child: Text('저장'))
              ],
            ),
          )
        ],
      ),
    ),
  )).then((value) {
    if (frontFlag) {
      controller.randomVl.value = value;
    } else {
      controller.randomV2.value = value;
      controller.globalKey.currentState?.play();
    }
  });
}

List<int> getList(int value) {
  if (value == 0) {
    return List.generate(9, (index) => index + 1);
  } else {
    int list = 10;
    if (value == 4) {
      list = 5;
    }
    return List.generate(list, (index) => index);
  }
}

getItem(int value) {
  if (value == 0) {
    return List.generate(9, (index) {
      return FortuneItem(
          style: FortuneItemStyle(
              color: Colors.blue,
              textAlign: TextAlign.right,
              borderWidth: 1,
              borderColor: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Transform.rotate(
                angle: pi / 2,
                child: Text(
                    style: TextStyle(fontSize: 20), (index + 1).toString()),
              ),
            ),
          ));
    });
  } else {
    int list = 10;
    if (value == 4) {
      list = 5;
    }
    return List.generate(list, (index) {
      return FortuneItem(
          style: FortuneItemStyle(
              color: Colors.blue,
              textAlign: TextAlign.right,
              borderWidth: 2,
              borderColor: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Transform.rotate(
                angle: pi / 2,
                child: Text(style: TextStyle(fontSize: 20), (index).toString()),
              ),
            ),
          ));
    });
  }
}

int forRandom(int front) {
  if (front == 0) {
    return Fortune.randomInt(1, 9);
  } else if (front >= 1 && front <= 3) {
    return Fortune.randomInt(0, 9);
  } else if (front == 4) {
    return Fortune.randomInt(0, 5);
  } else {
    // Handle other cases if needed
    return -1; // Placeholder for other cases
  }
}

class circleRan {
  static List<int> frontNums = List.generate(5, (index) => index);
  static List<FortuneItem> frontNumsItems = List.generate(5, (index) {
    return FortuneItem(
        style: FortuneItemStyle(
            color: Colors.blue,
            textAlign: TextAlign.right,
            borderWidth: 2,
            borderColor: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Transform.rotate(
              angle: pi / 2,
              child: Text(style: TextStyle(fontSize: 20), (index).toString()),
            ),
          ),
        ));
  });
}

// Obx(()=>
//     Column(
//       children: [
//         Expanded(
//           child: FortuneWheel(
//             selected: controller.rxStream.value,
//             animateFirst: false,
//             duration: const Duration(seconds: 3),
//             items: controller.itemss,
//             onAnimationEnd: (){
//               controller.WheelStop();
//             },
//           ),
//         ),
//         TextButton(onPressed: (){
//           controller.startBtn();
//           // streamController.add(Fortune.randomInt(0, items.length));
//         }, child: Text('Start${controller.rxStream.value}')),
//
//         // StreamBuilder<int>(
//         //   stream: controller.streamController.stream,
//         //   builder: (context, snapshot) {
//         //     if (snapshot.hasData) {
//         //       // Stream에서 데이터를 수신하는 리스너를 등록
//         //       return Text('Selected value: ${snapshot.data}');
//         //     } else {
//         //       return CircularProgressIndicator();
//         //     }
//         //   },
//         // ),
//         // StreamBuilder(
//         //   stream: streamController.stream,
//         //   builder: (context, snapshot) => snapshot.hasData
//         //       ? _text(snapshot)
//         //       : Container(),
//         // )
//       ],
//     ),)
