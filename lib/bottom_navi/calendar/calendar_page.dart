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

  Map<DateTime, List<Event>> _events = {};


  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return _events[day] ?? [];
  }

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
                          //2024-01-27
                          print('Calend_${day.day}');
                          if (day.weekday == DateTime.saturday){
                            print('ssss');
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

                              print('sSSS${selectedDay.year}');
                              DateTime dateTime = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

                              List <Event> s = _getEventsForDay(dateTime);

                              if (s.isEmpty) {
                                DateTime dateTime = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                                List<Event> e = [
                                  Event("Event Title1"),
                                  Event("Event Title2")
                                ];
                                if (_events.containsKey(dateTime)) {
                                  _events[dateTime]!.addAll(e);
                                } else {
                                  _events[dateTime] = List.from(e);
                                }
                                print('dd___${_events.toString()}');
                              }else{
                                print('dddd${s.toString()}');

                              }

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
