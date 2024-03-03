import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:newlotto/bottom_navi/calendar/calendar_controller.dart';
import 'package:newlotto/bottom_navi/record/record_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/Event.dart';

class CalendarPage extends StatefulWidget {

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDay;

  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  GetBuilder<CalendarController>(
          init:  CalendarController(),
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
                        firstDay: DateTime.utc(2012, 01, 01),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month'
                        },
                        calendarStyle: CalendarStyle(
                          markerSize: 10.0,
                          markerDecoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                          ),
                        ),
                        eventLoader: (day) {
                          if (day.weekday == DateTime.saturday){
                            return [Event('DAY!')];
                          }
                          return [];
                        },
                        selectedDayPredicate:(day){
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected:(selectedDay, focusedDay){
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }
                        } ,
                      ),
                    ],
                  ),
                ));
          },
        )
    );  }
}
