import 'package:get/get.dart';
import 'package:newlotto/model/loto.dart';

import '../../db/dbhelper.dart';
import '../../model/Event.dart';

class CalendarController extends GetxController {


  Map<DateTime, List<Event>> _events = {};


  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return _events[day] ?? [];
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

  void getSaturdayEvent() async {

    // 로또 DB 정보
    List<Loto> lotos = await DBHelper().getLoto();
    // 추첨일 + Event 저장 1년 단위
    // for (int i)

  }


}