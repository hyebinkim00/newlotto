
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newlotto/home_contents/random/controller/random_controller.dart';
import 'package:path/path.dart';



class UtilDialog {
  // 제거 할 숫자 , 포함할 숫자
  //   static void selectNumbers(BuildContext context, bool range, List<int> origin, Function(List<int>) nums)

  static void selectNumbers(bool range) {
    // 컨트롤러 초기화

    final RandomController randomController = Get.find<RandomController>();

    List<int> i = List<int>.from(randomController.includeList);
    List<int> e = List<int>.from(randomController.excludeList);

    // 다이어로그에서 선택한 값
    List<int> sle = range ? List<int>.from(i) : List<int>.from(e);


    Get.defaultDialog(
        title: range ? '포함 할 숫자를 선택하세요!' : '제외 할 숫자를 선택하세요!',
        content:
            // Obx(()=>
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 600,
              height: 500,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 4, // 가로 간격을 조절하세요.
                  mainAxisSpacing: 4, // 세로 간격을 조절하세요.
                ),
                itemBuilder: (BuildContext dialogContext, index) {
                  int number = index + 1;
                  bool s = i.contains(number) || e.contains(number);
                  return NumberBall(
                      num: number,
                      initialSelected: s,
                      range: range,
                      i: i,
                      e: e,
                      onSelect: (b) {
                        if (!b.value) {
                         sle.add(number);
                        } else {
                          sle.remove(number);
                        }
                      });
                },
                itemCount: 45,
              ),
            )
          ],
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                if (range) {
                  randomController.includeList.value = sle;
                } else {
                  randomController.excludeList.value = sle;
                }

                Get.back();
              },
              child: Text('선택'),
            ),
          )
        ]);
  }

  static Widget NumberBalla(int numbers, bool s) {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: s ? Colors.grey : Colors.transparent,
        border: Border.all(
          color: Colors.black, // 테두리 색
          width: 2.0, // 테두리 두께
        ),
      ),
      child: Center(
        child: Text(
          '$numbers',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
//
class NumberBall extends GetWidget<RandomController> {
  Function(RxBool d) onSelect;
  RxBool isSelected = false.obs; // RxBool을 사용하여 상태를 관리
  int num;
  bool range;
  List<int> i;
  List<int> e;
  List<int> t= [ ];
  // 공 색상 --->  투명, 파랑, 빨간

  NumberBall(
      {required this.num,
      required bool initialSelected,
      required this.range,
      required this.i,
      required this.e,
      required this.onSelect})
      : isSelected = initialSelected.obs; // : 는 초기화 한다는뜻
  // NumberBall ( 해당 번호 , 원래 선택된 상태인지 )

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(range){
          t = i;
        } else{
          t = e;
        }

        // isSelected 값을 토글
        if (!range && i.contains(num)) {
          Fluttertoast.showToast(msg: '포함할 숫자에 적용되어잇습니다.');
          return;
        }
        if (range && e.contains(num)) {
          Fluttertoast.showToast(msg: '제외할 숫자에 적용되어잇습니다.');
          return;
        }

          if (!isSelected.value) {
            if(t.length <5){
              t.add(num);
              onSelect(isSelected);
              isSelected.toggle();
            } else {
              Fluttertoast.showToast(msg: '최대 5개까지만 선택가능합니다.');
            }
          } else {

            t.remove(num);
            onSelect(isSelected);
            isSelected.toggle();
          }

          print('dddgso${t.length}');
          print('rrrr${range}');

      },
      child: Obx(() =>
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected.value ? i.contains(num)? Colors.blue : e.contains(num)? Colors.red: range ? Colors.blue: Colors.red
                  : Colors.white,
              // i 에 해당하면 파란 e 에 포함되면 빨간 아니면 White
              border: Border.all(
                color: Colors.black, // 테두리 색
                width: 2.0, // 테두리 두께
              ),
            ),
            child: Center(
              child: Text(
                '$num',
                style: TextStyle(
                  color: isSelected.value ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
    );
  }
}




getColors(int value2) {
  Color color = Colors.white;

  print('fefeC${color}');
  return color;
}

class YourDialog extends StatelessWidget {
  List<int> ll = [];

  // YourDialog({required this.ll});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Numbers'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            int number = index + 1;
            bool isSel = ll.contains(number);
            return NumberBall2(
              num: number,
              isSelected: isSel,
              onSelect: (isSelected) {
                // 아이템이 선택될 때 처리
                print('Number $number is selected: $isSelected');
              },
            );
          },
          itemCount: 45,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

// class NumberGrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 5,
//         crossAxisSpacing: 4,
//         mainAxisSpacing: 4,
//       ),
//       itemBuilder: (context, index) {
//         int number = index + 1;
//         bool isSelected =
//         return NumberBall2(
//           num: number,
//           onSelect: (isSelected) {
//             // 아이템이 선택될 때 처리
//             print('Number $number is selected: $isSelected');
//           },
//         );
//       },
//       itemCount: 45,
//     );
//   }
// }

class NumberBall2 extends StatefulWidget {
  final int num;
  final bool isSelected;
  final ValueChanged<bool> onSelect;

  NumberBall2(
      {required this.num, required this.isSelected, required this.onSelect});

  @override
  _NumberBall2State createState() => _NumberBall2State(isSelected);
}

class _NumberBall2State extends State<NumberBall2> {
  bool isSelected;

  _NumberBall2State(this.isSelected);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelect(isSelected);
      },
      child: Container(
        width: 50,
        height: 50,
        color: isSelected ? Colors.blue : Colors.grey,
        child: Center(
          child: Text(
            widget.num.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
