import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlotto/db/dbhelper.dart';
import 'package:newlotto/model/random.dart';

class RandomNumsController extends GetxController {

  RxList<RandomNums> dataList = <RandomNums>[].obs;
  RxList<String> s = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    s.value = ['1','2','3'];
    getList();
  }

  Future<void> getList() async {
    dataList.value= await DBHelper().getRandomList();

  }

  void dialogShow(int ids){
    Get.dialog(AlertDialog(
      content: Text(
        "해당항목을 삭제할까요?",
      ),
      actions: <Widget>[
        TextButton(
          child: new Text("취소"),
          onPressed: ()  {
            Get.back();

          },
        ),
       TextButton(
          child: new Text("확인"),
          onPressed: () async {
            await DBHelper().removeList(ids);
            getList();
            Get.back();
          },
        ),
      ],
    ));
  }

  Future<void> removeList(int ids) async {
    await DBHelper().removeList(ids);
    getList();
  }



}