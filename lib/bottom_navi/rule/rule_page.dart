import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:newlotto/bottom_navi/record/record_controller.dart';
import 'package:newlotto/bottom_navi/rule/rule_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/Event.dart';

class RulePage extends StatelessWidget {

  // 달력 페이지로 바꿔야지

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  GetBuilder<RuleController>(
          init:  RuleController(),
          builder: (controller) {
            return SafeArea(
                top: true,
                child: Container(
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TableCalendar(
                        locale: 'ko_KR',
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month'
                        },
                        calendarStyle: CalendarStyle(
                          markerSize: 10.0,
                          markerDecoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                          ),
                        ),
                        eventLoader: (day) {
                          if (day.weekday == DateTime.saturday){
                            return [Event('DAY!')];
                          }
                          return [];
                        } ,

                      ),
                    ],
                  ),
                ));
          },
        )
    );  }
}
