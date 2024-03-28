
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newlotto/model/myNums.dart';
import 'package:path/path.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../db/dbhelper.dart';
import '../model/loto.dart';
import '../model/newNum.dart';
import '../model/qrScan.dart';
import '../mypage_list/controller/recordnums_controller.dart';
import '../mypage_list/view/recordnums_page.dart';
import '../self/controller/self_controller.dart';
import 'color_utils.dart';

class DialogUtils {

  // QrPage 결과 다이어로그
  static void qrResult(qrinfo) {
    final qrScan info = qrinfo;
    List<NumInfo> db ;
    Get.dialog(AlertDialog(
      title: Text('스캔 결과'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${info.serial}',style: TextStyle(color:Colors.blue ),),
              Text('${info.date}'),],
          )
          ,Text('당첨번호',style: TextStyle(fontWeight: FontWeight.bold),),
          // 당첨번호
          SizedBox(
            height: 30,
            width: 500,
            child: GridView.builder(
                itemCount: info.winnerList!.length,
                itemBuilder: (BuildContext context, int index){
                return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: info.winnerList![index].color,
                        ),
                            child: Center(
                              child: Text(
                                '${info.winnerList![index].number}',
                                style: TextStyle(
                                  color: info.winnerList![index].color == Colors.transparent?
                                  Colors.black:Colors.white,
                                  // 텍스트 색상 설정
                                  fontSize: 15.0, // 텍스트 크기 설정
                                ),
                              ),
                            )
                      );
                },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:8, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 1 / 1, //item 의 가로 세로의 비율
              mainAxisSpacing: 3, //수평 Padding
              crossAxisSpacing: 3, //수직 Padding
            ),),
          ),
          Text('${info.notice}'),
          Container(
            height: 200 ,
              width: 400,
              child: ListView.builder(
            itemCount: info.selectednums!.length,
              itemBuilder: (BuildContext context, int index){
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${info.selectednums![index].results}'),
                  Container(
                    height: 40,
                    width: 200,// Set the height of the containers as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, indexs) {
                        return  Container(
                          width: 25,
                          margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: info.selectednums![index].lists![indexs].color,
                            ),
                            child: Center(
                              child: Text(
                                '${info.selectednums![index].lists![indexs].number}',
                                style: TextStyle(
                                  color: Colors.black,
                                  // 텍스트 색상 설정
                                  fontSize: 15.0, // 텍스트 크기 설정
                                ),
                              ),
                            )
                        );
                      },
                    ),
                  )
                ],
              );
              }))
        ],
      ),
      actions: <Widget>[
        Container(
          child: ElevatedButton(
            onPressed: () async {
              // DB 저장
              List<NumInfo> numInfoList = [];
              for(int i = 0; i < info.selectednums!.length ; i++) {
                print('QQQQRRR___${info.selectednums![i].lists![0].number}');
                print('QQQQRRR___${info.selectednums![i].lists![1].number}');
                print('QQQQRRR___${info.selectednums![i].lists![2].number}');
                print('QQQQRRR___${info.selectednums![i].lists![3].number}');
                print('QQQQRRR___${info.selectednums![i].lists![4].number}');

                // 반복할 코드
                NumInfo numInfo = NumInfo(
                    num1: int.parse('${info.selectednums![i].lists![0].number}'),
                    num2: int.parse('${info.selectednums![i].lists![1].number}'),
                  num3: int.parse('${info.selectednums![i].lists![2].number}'),
                  num4: int.parse('${info.selectednums![i].lists![3].number}'),
                  num5: int.parse('${info.selectednums![i].lists![4].number}'),
                  num6: int.parse('${info.selectednums![i].lists![5].number}'),
                );
                numInfoList.add(numInfo);

              }

              print('DDD${numInfoList.toString()}');
              MyNums mynums = MyNums(serial: info.serial,myNum: numInfoList);
             await DBHelper().insertQrData(mynums);
              Get.back(); //창 닫기
            },
            child: Text("저장하기"),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              Get.back(); //창 닫기
            },
            child: Text("다시 스캔하기"),
          ),
        ),
      ],
    ));
  }

 // RandomPage 에서 제거 / 포함할 숫자 고르기
 //  static Future selectNums( {required String title, required Function(int) okFuc}) async{
 //    Get.dialog(AlertDialog(
 //      content: SizedBox(
 //        height: 500,
 //        child: Expanded(
 //          child: GridView.builder(
 //            itemCount: 45,
 //            gridDelegate:
 //          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
 //            itemBuilder: (BuildContext context, int index) {
 //              return GestureDetector(
 //                onTap: (){
 //                  okFuc(index);
 //                },
 //                child:NumberBall(index+1) ,
 //              );
 //            },),
 //        ),
 //      ),
 //    ));
 //  }
 //
 //
 //  static Widget NumberBall(int numbers){
 //    return Container(
 //      width: 50,
 //      height: 50,
 //      margin: EdgeInsets.all(5),
 //      decoration: BoxDecoration(
 //        shape: BoxShape.circle,
 //        color: Colors.blue,
 //        border: Border.all(
 //          color: Colors.black, // 테두리 색
 //          width: 2.0, // 테두리 두께
 //        ),
 //      ),
 //      child: Center(
 //        child: Text(
 //          '$numbers',
 //          style: TextStyle(
 //            color: Colors.white,
 //            fontWeight: FontWeight.bold,
 //          ),
 //        ),
 //      ),
 //    );
 //  }

  // SelfPage 에서 회차 변경하는 다이어로그
  static selectSerial(BuildContext context, SelfController controller) async {
    List<Loto> lotos = await DBHelper().getLoto();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(textAlign: TextAlign.center, '회차 선택'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                itemCount: lotos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${lotos[index].drwNo}' +
                        '회 ' + '( ${lotos[index].drwNoDate} 추첨 )'),
                    onTap: () {
                      controller.btnText.value = lotos[index].drwNo!;
                      Navigator.of(context).pop();
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
          );
        });
  }

  static confirmSelf(MyNums selectLists){

    Get.dialog(AlertDialog(
      title: Text('결과'),
      content:  Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey,width: 1.0)
        ),
        height: selectLists.myNum!.length*60,
        width: 400,// 각 항목의 높이를 설정합니다.
        // 정보 한개씩 박스 안에 표시
        child: Column(
          children: [
            Text('${selectLists.serial}회',style: TextStyle(fontWeight: FontWeight.bold),),
            FutureBuilder(
              // controller.qrtest 안에 serial , List<QRInfo> 리스트 (DB 리스트)
                future: RecordNumsController.getDetail(selectLists.serial!,selectLists.myNum??[]),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // return CircularProgressIndicator();// 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
                    return Container(color: Colors.transparent,);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No data available'); // 데이터가 없는 경우에 대한 처리를 추가합니다.
                  }
                  else if (snapshot.data != null && snapshot.hasData) {
                    print('SSSSBBB${snapshot.data}');
                    print('SSSlllB${snapshot.data!.length}');

                    //controller.QRballLists.value = snapshot.data!;
                  }
                  return Expanded(
                    // 세로 리스트 (NumInfo 갯수)
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Container(
                          width: 300.0,
                          height: 50.0,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal, // 가로 방향으로 스크롤합니다.
                            itemCount: snapshot.data![index].length,
                            itemBuilder: (BuildContext context , int indexs){
                              return Container(
                                width: 25.0,
                                height: 50.0,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: snapshot.data![index][indexs].color,
                                ),
                                child: Center(
                                    child: Text(
                                      '${snapshot.data![index][indexs].number}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        // 텍스트 색상 설정
                                        fontSize: 15.0, // 텍스트 크기 설정
                                      ),
                                    )),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          child: ElevatedButton(
            onPressed: () async {
              Get.back(); //창 닫기

            },
            child: Text("다시 입력하기"),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () async {
              await DBHelper().insertSelfData(selectLists);
              Get.back();
              Get.off(RecordNumsPage());
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => RecordNumsPage()),
              // );
            },
            child: Text("저장 하기"),
          ),
        ),
      ],

    ));
  }



}
