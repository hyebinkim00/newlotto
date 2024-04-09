import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

class VerticalPage extends StatefulWidget {
  const VerticalPage({super.key});

  @override
  State<VerticalPage> createState() => _VerticalPageState();
}


///https://www.dhlottery.co.kr/gameResult.do?method=statByNumber&sttDrwNo=14&edDrwNo=1114
// srchType (기본값 list -> 번호순 , dir -> 당첨횟수 순

// + 날짜 선택기
// + 최근 10회차 기준으로 확인




class _VerticalPageState extends State<VerticalPage> {
  List<VBarChartModel> bardata = [
    VBarChartModel(
      index: 0,
      label: "Strawberry",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 20,
      tooltip: "20 Pcs",
      description: Text(
        "Most selling fruit last week",
        style: TextStyle(fontSize: 10),
      ),
    ),
    VBarChartModel(
      index: 1,
      label: "Apple",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 55,
      tooltip: "55 Pcs",
      description: Text(
        "Most selling fruit this week",
        style: TextStyle(fontSize: 10),
      ),
    ),
    VBarChartModel(
      index: 2,
      label: "Broccoli",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 12,
      tooltip: "12 Pcs",
    ),
    VBarChartModel(
      index: 3,
      label: "Chilli",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 1,
      tooltip: "5 Pcs",
    ),
    VBarChartModel(
      index: 4,
      label: "Manggo",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 15,
      tooltip: "15 Pcs",
    ),
    VBarChartModel(
      index: 5,
      label: "Asparagus",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
      description: Text(
        "Favorites vegetables",
        style: TextStyle(fontSize: 10),
      ),
    ),
    VBarChartModel(
      index: 5,
      label: "Asparagus",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
      description: Text(
        "Favorites vegetables",
        style: TextStyle(fontSize: 10),
      ),
    ),
    VBarChartModel(
      index: 5,
      label: "Asparagus",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
      description: Text(
        "Favorites vegetables",
        style: TextStyle(fontSize: 10),
      ),
    ),
    VBarChartModel(
      index: 5,
      label: "Asparagus",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
      description: Text(
        "Favorites vegetables",
        style: TextStyle(fontSize: 10),
      ),
    ),
  ];

  List<VBarChartModel> bardata2 = List.generate(45, (index) {
    return VBarChartModel(
      index: index,
      label: "$index",
      jumlah: 30, // 예시로 5를 곱하여 다양한 값 생성
      tooltip: "${(index + 1) * 5} Pcs",
      description: Text(
        "Description for Fruit $index",
        style: TextStyle(fontSize: 10),
      ),
      colors: [Colors.orange, Colors.deepOrange],
    );
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: VerticalBarchart(
          maxX: 250,
          data: bardata2,
          showLegend: true,
          showBackdrop: true,
          barStyle: BarStyle.DEFAULT,
          alwaysShowDescription: true,
          legend: [
            Vlegend(
              isSquare: true,
              color: Colors.orange,
              text: "Fruits",
            ),
            Vlegend(
              isSquare: false,
              color: Colors.teal,
              text: "Vegetables",
            )
          ],
        ),
      ),
    );
  }
}
