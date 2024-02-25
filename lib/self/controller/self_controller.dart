import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/loto.dart';

class SelfController extends GetxController {
  RxList<Widget> widgets = <Widget>[].obs;
  RxList<RxList<bool>> isSelectedLists = List.generate(5, (_) => List.generate(45, (_) => false).obs).obs; // 위젯마다 isSelected 목록을 저장할 RxList

  RxList<bool> isSelected = List.generate(45, (index) => false).obs;
  RxInt btnText = 0.obs;

  Map<int, RxList<int>> selectLists = {
    0: <int>[].obs,
    1: <int>[].obs,
    2: <int>[].obs,
    3: <int>[].obs,
    4: <int>[].obs,
  };


  @override
  void onInit() {
    // var last = Get.arguments['lastSerial'];
    // serial.value = last;
    super.onInit();
  }



  void toggleSelections(int widgetIndex, int gridIndex) {
    final isSelectedList = selectLists[widgetIndex];

    if (isSelectedList!.length < 6 ) {
      isSelectedLists[widgetIndex][gridIndex] = !isSelectedLists[widgetIndex][gridIndex];

      isSelectedList.contains(gridIndex + 1)
          ? isSelectedList.remove(gridIndex + 1)
          : isSelectedList.add(gridIndex + 1);


    } else if (isSelectedList!.length == 6  && isSelectedLists[widgetIndex][gridIndex]) {
      // 선택 목록이 이미 6개이고 새로운 항목을 추가하려고 할 때는 가장 오래된 것을 제거
      isSelectedLists[widgetIndex][gridIndex] = !isSelectedLists[widgetIndex][gridIndex];

      isSelectedList.remove(gridIndex + 1);
    }

    isSelectedList.sort();

    print('GFFFFF__S${selectLists.toString()}_____${isSelectedList.toString()}');
  }



  Widget items(int index) {
    // isSelectedLists.add(List.generate(45, (index) => false).obs); // 새로운 위젯에 대한 isSelected 목록을 추가
    print('itemssss_${index}');
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.orangeAccent), // 테두리 스타일 설정
        ),
        height: 500,
        width: 300, // 각 항목의 너비
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.orangeAccent), // 테두리 스타일 설정
              ),
              height: 50,
              width: double.infinity,
              child:  Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Text('${index}'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.orange,
                      child: Center(
                        child: Text('1000원'),
                      ),
                    ),
                  ),
                ],),
            ),
            SingleChildScrollView(
              child: GridView.builder(
                padding: EdgeInsets.only(left: 3,right: 3),
                physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true, // GridView가 자신의 크기에 맞춰야 함
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 10, // 가로 간격을 조절하세요.
                    mainAxisSpacing: 4, // 세로 간격을 조절하세요.
                    crossAxisCount: 7),
                itemCount: 45, // GridView에 표시할 항목 수
                itemBuilder: (context, gridIndex) {
                  return GestureDetector(
                      onTap: () {
                        //     color: isSelectedLists[index][gridIndex] ? Colors.black : Colors.yellow,
                        print('ListView 아이템 ${index}에서 Grid item $gridIndex 클릭됨');
                        toggleSelections(index, gridIndex);
                      },
                      child: Obx(
                            () => SizedBox(
                          height: 60,
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.orangeAccent),
                                        left: BorderSide(
                                            color: Colors.orangeAccent),
                                        right: BorderSide(
                                            color: Colors.orangeAccent)),
                                    color: isSelectedLists[index][gridIndex]
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  height: 10),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.transparent),
                                        left: BorderSide(
                                            color: Colors.transparent),
                                        right: BorderSide(
                                            color: Colors.white)),
                                    color: isSelectedLists[index][gridIndex]
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  child: Center(child: Text('${gridIndex+1}'),),
                                  height: 30),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.orangeAccent),
                                        left: BorderSide(
                                            color: Colors.orangeAccent),
                                        right: BorderSide(
                                            color: Colors.orangeAccent)),
                                    color: isSelectedLists[index][gridIndex]
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  height: 10)
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
      //       Container(
      //         height: 5,
      //         child:Row( mainAxisAlignment:MainAxisAlignment.center,
      //         children: [
      //           OutlinedButton(
      //           onPressed: () {
      //           // DialogUtils.selectSerial(context, controller);
      //       },
      //           style: ElevatedButton.styleFrom(
      //             side: BorderSide(
      //                 width: 1, color: Colors.orangeAccent), // 테두리 설정
      //           ),
      //           child: Text('회차 변경',style: TextStyle(color: Colors.orangeAccent),),)
      //     ],
      //   ),
      // ),
  ],
    )));
  }



}