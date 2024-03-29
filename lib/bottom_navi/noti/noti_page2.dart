import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/bottom_navi/noti/controller/noti_controller.dart';

class NotiPage2 extends StatefulWidget {

  @override
  State<NotiPage2> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage2> {
  int _selectedIndex = -1; // 선택된 패널 인덱스
  List<Item> _data = generateItems(3); // 패널 데이터 생성
  
  List<List<String>> data = [
    ['등위', '당첨방법', '당첨금의 배분 비율'],
    ['1등', '6개 번호 일치', '총 당첨금 중 4등, 5등 금액을 제외한 금액의 75%'],
    ['2등', '5개 번호 일치\n+ 보너스 번호 일치', '총 당첨금 중 4등, 5등 금액을 제외한 금액의 12.5%'],
    ['3등', '5개 번호 일치', '총 당첨금 중 4등, 5등 금액을 제외한 금액의 12.5%'],
    ['4등', '4개 번호 일치', '5,0000원'],
    ['5등', '3개 번호 일치', '5,000원']
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _selectedIndex = isExpanded ? -1 : index;
          });
        },
        children: _data.map<ExpansionPanelRadio>((Item item) {
          return ExpansionPanelRadio(
            value: item.index,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerValue),
              );
            },
            body: _buildPanelBody(item.index), // 패널 본문 위젯 반환

          // body: ListTile(
            //   title: Text(item.expandedValue),
            // ),
          );
        }).toList(),
        initialOpenPanelValue: _selectedIndex,
      ),
    );
  }
}

Widget _buildPanelBody(int index) {
  if (index == 0) {
    return Table( // 첫 번째 패널에는 Table 위젯 반환
      children: [
        TableRow(
          children: [
            TableCell(
              child: Text('Table Cell 1'),
            ),
            TableCell(
              child: Text('Table Cell 2'),
            ),
          ],
        ),
      ],
    );
  } else {
    return Text('이 패널의 내용입니다.'); // 나머지 패널에는 Text 위젯 반환
  }
}




class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.index,
  });

  String expandedValue;
  String headerValue;
  int index;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: '패널 $index',
      expandedValue: '이 패널의 내용입니다.',
      index: index,
    );
  });
}

