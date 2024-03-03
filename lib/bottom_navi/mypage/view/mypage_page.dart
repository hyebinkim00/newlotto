import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/mypage/controller/mypage_controller.dart';
import 'package:newlotto/record_nums/view/recordnums_page.dart';

import '../../../config/route_names.dart';
import '../../../model/selfnum.dart';

class MyPage extends StatelessWidget {
  // 앱바에서 뒤로 버튼
  // 탭바로 직접입력 , QR스캔 분리
  final List<String> cardText1 = ['저장기록', '구입번호 당첨확인', '랜덤번호 생성목록'];
  final List<String> cardText2 = ['알림설정', '푸시알림 기록', '푸쉬알림 동의'];
  final List<String> cardText3 = ['도움말', '앱 사용방법', '로또 당첨금 규칙'];

  @override
  Widget build(BuildContext context) {
    List<String> combinedItems = [];
    // 리스트들을 하나로 합침
    combinedItems.addAll(cardText1);
    combinedItems.addAll(cardText2);
    combinedItems.addAll(cardText3);

    return Scaffold(
      body: GetBuilder<MyPageController>(
        init: MyPageController(),
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(overscroll: false),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index == 0 ||
                            index == cardText1.length ||
                            index == cardText1.length + cardText2.length) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  combinedItems[index],
                                  style: TextStyle(fontSize: 30), // 텍스트 크기 30으로 설정
                                ),
                                onTap: (){
                                  performAction(context,index);
                                  },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          );
                        }

                        // 나머지 경우는 구분선을 추가하지 않고 각 항목을 반환
                        Color color = (index % 2 == 0) ? Colors.blue : Colors.green;
                        return Column(
                            //  color: color,
                            children: [
                              ListTile(
                                title: Text(combinedItems[index]),
                                onTap: (){
                                  performAction(context,index);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                            ]);
                      },
                      itemCount: combinedItems.length,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }

  void performAction(BuildContext context, int index) {
    // 각 항목에 대한 특정 기능을 수행합니다.
    print('Performing action for $index');
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecordNumsPage()),
      );    }
    // 여기에 각 항목에 대한 특정 기능을 추가할 수 있습니다.
    // 예를 들어, 해당 항목에 대한 화면 이동 또는 다른 작업을 수행할 수 있습니다.
  }
}
