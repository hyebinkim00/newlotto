import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/db/dbhelper.dart';

import '../controller/randomnums_controller.dart';

class RandomNumsPage extends StatefulWidget {
  @override
  State<RandomNumsPage> createState() => _RandomNumsPageState();
}

class _RandomNumsPageState extends State<RandomNumsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // 그림자를 제거
        centerTitle: true,
        title: Text(
          '랜덤번호 저장목록',
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
      body: GetBuilder<RandomNumsController>(
        init: RandomNumsController(),
        builder: (controller) {
          return SafeArea(
              top: true,
              child: Obx(() {
                if (controller.dataList.isEmpty) {
                  return Center(
                    child: Text('저장된 기록이 없습니다.'),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true, // ListView가 내용에 맞게 축소되도록 함
                      itemCount: controller.dataList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: index == 0 ||
                                      controller.dataList[index].date !=
                                          controller.dataList[index - 1].date
                                  ? true
                                  : false,
                              child: ListTile(
                                title: Text(
                                  '${controller.dataList[index].date}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                int? s = controller.dataList[index].id;
                                controller.dialogShow(s);
                                // controller.removeList(s);

                                print('IDSSS${controller.dataList[index].id}');
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(6, (indexs) {
                                    return Container(
                                      width: 50, // 아이템의 고정된 너비
                                      height: 40,
                                      // margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Container(
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            '${controller.dataList[index].nums!.toList()[indexs]}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        );
                        // } else {
                        //   return Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: List.generate(6, (indexs) {
                        //       return Container(
                        //         width: 50, // 아이템의 고정된 너비
                        //         height: 40,
                        //         // margin: EdgeInsets.all(5),
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Colors.white,
                        //         ),
                        //         child: Container(
                        //           width: double.infinity,
                        //           child: Center(
                        //             child: Text(
                        //               '${controller.dataList[index].nums!.toList()[indexs]}',
                        //               style: TextStyle(
                        //                 color: Colors.black,
                        //                 fontSize: 15.0,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     }),
                        //   );
                        // }
                        // Otherwise, just show the nums value
                      });
                }
              }));
        },
      ),
    );
  }
}
