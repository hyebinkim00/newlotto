import 'package:flutter/material.dart';
import 'package:newlotto/self/controller/self_controller.dart';

class InputList extends StatelessWidget {
  late SelfController controller;

  InputList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // margin: EdgeInsets.only(left: 10, top: 15, bottom: 15),
      // height: 550,
      // //  height: MediaQuery.of(context).size.height*0.8,
      // width: 500,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return controller.items(index);
        },
      ),
    );
  }
}
