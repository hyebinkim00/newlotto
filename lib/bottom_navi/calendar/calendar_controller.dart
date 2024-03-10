import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:newlotto/model/loto.dart';

import '../../db/dbhelper.dart';
import '../../model/Event.dart';
import '../../retrofit/retrofit_client.dart';

class CalendarController extends GetxController {
  Map<DateTime, List<Event>> _events = {};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSaturdayEvent();
  }

  void getSaturdayEvent() async {
    // 로또 DB 정보
    List<Loto> lotos = await DBHelper().getLoto();
    print('Calend_${lotos.length}');


    for(int i=0; i< lotos.length ; i++) {
      String dateString = lotos[i].drwNoDate.toString();
      List<String> dateParts = dateString.split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2]);

      DateTime dateTime = DateTime(year, month, day);
      List<Event> e = [Event("매주 토요일은 로또 추첨날!"), Event(lotos[i].toString()), ];
      if (_events.containsKey(dateTime)) {
        _events[dateTime]!.addAll(e);
      } else {
        _events[dateTime] = List.from(e);
      }
    }

  }

  List<Event> getEventsForDay(DateTime day) {
    // Implementation example
    return _events[day] ?? [];
  }




}
