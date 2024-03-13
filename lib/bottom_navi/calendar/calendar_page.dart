import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:newlotto/bottom_navi/calendar/calendar_controller.dart';
import 'package:newlotto/bottom_navi/record/record_controller.dart';
import 'package:newlotto/push/firebase_message.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/Event.dart';

class CalendarPage extends StatefulWidget {

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  late final ValueNotifier<List<Event>> _selectedEvents;

  DateTime? _selectedDay;

  DateTime _focusedDay = DateTime.now();

  Map<DateTime, List<Event>> _events = {};

  get flutterLocalNotificationsPlugin

  => null;


  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return _events[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      // ),
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
                        firstDay: DateTime.utc(2023, 01, 01),
                        lastDay: DateTime.utc(2024, 12, 12),
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
                          if (day.weekday == DateTime.saturday){
                            print('ssss');
                            print('Calend_${day.year}${day.month}${day.day}');
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

                              List <Event> s = controller.getEventsForDay(dateTime);

                              if (s.isEmpty) {
                                if(selectedDay.weekday == DateTime.saturday){
                                  _selectedEvents.value = [Event("매주 토요일은 로또 추첨날!")];
                                }else{
                                  _selectedEvents.value = s;
                                }
                                // print('dd___${_events.toString()}');
                              }else{

                                _selectedEvents.value = s;
                                print('dddd${s.toString()}');

                              }

                            });
                          }
                        } ,
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ValueListenableBuilder<List<Event>>(
                          valueListenable: _selectedEvents,
                          builder: (context, value, _) {
                            return ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: ListTile(
                                    onTap: () => print('${value[index]}'),
                                    title: Text('${value[index]}'),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ));
          },
        )
    );  }
}
