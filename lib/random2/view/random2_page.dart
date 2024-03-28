import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:newlotto/db/dbhelper.dart';
import 'package:newlotto/model/random.dart';

import '../../ui/util_dialog.dart';
import '../controller/random2_controller.dart';

class Random2Page extends GetView<Random2Controller> {
  // 번호추첨 -> 제외 하고 싶은 숫자 , 포함하고 싶은 숫자  , ---> 여섯개 숫자 랜덤 리스트 10개 == > 생성된 번호 저장 가능
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:10),
              Text('로또 번호를 만들어 드릴께요! \n포함하고 싶은 숫자와 제외하고 싶은 숫자를 선택해 주세요.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(height:40),
              Container(
                color: Colors.grey,
                height: 60.h,
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.black, // 테두리 선의 색상
                //     width: 2.0, // 테두리 선의 너비
                //   ),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text('포함할 숫자'),
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.includeList.clear();
                            },
                            child: Text('초기화',style:TextStyle(color: Colors.white) ,)),
                        TextButton(
                            onPressed: () {
                              UtilDialog.selectNumbers(true);
                            },
                            child: Text('추가',style:TextStyle(color: Colors.white)))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black12,
                height: 80.h,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(controller.includeList.length, (index) {
                      return Container(
                        width: 50.h, // 아이템의 고정된 너비
                        height: 40.h,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                '${controller.includeList[index]}',
                                style: TextStyle(
                                  color: Colors.black,
                                  // 텍스트 색상 설정
                                  fontSize: 15.0, // 텍스트 크기 설정
                                ),
                              ),
                            )),
                      );
                    },),
                  ),
                ),
              ),
            Container(
              color: Colors.grey,
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: Text('포함하지 않을 숫자'),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            controller.excludeList.clear();
                          },
                          child: Text('초기화',style:TextStyle(color: Colors.white) ,)),
                      TextButton(
                          onPressed: () {
                            UtilDialog.selectNumbers(false);
                          },
                          child: Text('추가',style:TextStyle(color: Colors.white) ,)),
                    ],
                  )
                ],
              ),
            ),
              Container(
                color: Colors.black12,
                height: 80.h,
                child: Obx(
                      ()=> Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(controller.excludeList.length, (index) {
                      return Container(
                        width: 50.h, // 아이템의 고정된 너비
                        height: 40.h,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                '${controller.excludeList[index]}',
                                style: TextStyle(
                                  color: Colors.black,
                                  // 텍스트 색상 설정
                                  fontSize: 15.0, // 텍스트 크기 설정
                                ),
                              ),
                            )),
                      );
                    },),
                  ),
                ),
              ),
              Container(
                height: 60.h,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: Text('랜덤수'),
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.allRandomNumbers.clear();
                            },
                            child: Text('초기화',style:TextStyle(color: Colors.white) ,)),
                        TextButton(
                            onPressed: () {
                              controller.generateRandomNumber();
                              },
                            child: Text('생성',style:TextStyle(color: Colors.white) ,)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black12,
                  child: Obx(
                        () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.allRandomNumbers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // List 생성
                            ...List.generate(controller.allRandomNumbers[index].length, (indexs) {
                              return Container(
                                width: 50.h, // 아이템의 고정된 너비
                                height: 40.h,
                                // margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      '${controller.allRandomNumbers[index][indexs]}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            // 버튼 추가
                            TextButton(
                              onPressed: () async{
                                print('SSSSSSS${controller.allRandomNumbers[index].toString()}');

                                DateTime dateTime = DateTime.now();

                                DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
                                var today = dateFormat.format(dateTime);
                                List<int> s = controller.allRandomNumbers[index];
                                // RandomNums r1 = RandomNums(date: '2024년 03월 27일', nums: Uint8List.fromList(s));
                                // await DBHelper().insertRandomList(r1);
                                RandomNums r = RandomNums(date: today, nums: Uint8List.fromList(s));
                                await DBHelper().insertRandomList(r);
                              }, child: Text('저장'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )

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
              // 이걸 써야겟다 ( 눌렀을때 번호 공개)
              // Obx(() => GestureDetector(
              //       onTap: () {
              //         controller.onTap2();
              //       },
              //       child: AnimatedContainer(
              //         duration: Duration(milliseconds: 500),
              //         curve: Curves.easeInOut,
              //         transform: Matrix4.rotationY(
              //             controller.angle.value * (3.1415927 / 180)),
              //         width: 100,
              //         height: 100,
              //         decoration: BoxDecoration(
              //           color: controller.backgroundColor.value,
              //           shape: BoxShape.circle,
              //         ),
              //         child: Center(
              //           child: Text(
              //             controller.isBack.value ? '' : 'Front',
              //             style: TextStyle(color: Colors.white),
              //           ),
              //         ),
              //       ),
              //     ))
            ],
          ),
        ),
      ),
    );
  }

  Widget createBox(bool iswu) => Container(
        key: ValueKey<bool>(iswu),
        color: iswu ? Colors.green : Colors.blue,
        width: iswu ? 200 : 100,
        height: iswu ? 200 : 100,
        child: Center(
          child: Text(
            '${controller.isSwitched}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<void> _showNumberInputDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter a Number'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^([1-9]|[1-3][0-9]|4[0-5])$')),
            ],
            decoration: InputDecoration(
              labelText: 'Number',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 닫기 버튼
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // 여기서 입력된 숫자를 사용하거나 저장할 수 있습니다.
                var enteredNumber = _controller.text;
                controller.inNum.value = enteredNumber;
                print('Entered Number: $enteredNumber');
                Navigator.of(context).pop(); // 닫기 버튼
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
