import 'dart:collection';
import 'dart:developer';

import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  static Map<DateTime, List<String>> mapna = {
    DateTime.now(): ["string"],
    DateTime.utc(2022, 7, 26): ["hello"]
  };
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  DateTime _selectedDay = DateTime.now();
  List<models_clock> _getEventsForDay(
      DateTime day, LinkedHashMap<DateTime, List<models_clock>?> map) {
    log(map[day].toString());
    return map[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimemanageBloc, TimemanageState>(
        builder: ((context, state) {
      if (state is BuildClockState) {
        final event = state.mclock;
        DateTime _focusedDay = state.selectday;
        log("day");

        return Container(
          child: TableCalendar(
            headerStyle: HeaderStyle(titleTextFormatter: (date, locale) => DateFormat.yMMM().format(date),),
            
            calendarStyle: CalendarStyle(weekendTextStyle: TextStyle(color: Theme.of(context).indicatorColor), markerDecoration: BoxDecoration(color: Theme.of(context).indicatorColor,shape: BoxShape.circle)),
            rowHeight: 58,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              _selectedDay = selectedDay;
              context.read<TimemanageBloc>().add(Changeday(focusday: focusedDay));
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              context.read<TimemanageBloc>().add(Changeday(focusday: focusedDay));
              log("changeday");
            },
            eventLoader: (day) {
              return _getEventsForDay(day, event!);
            },
          ),
        );
      } else {
        return Text('Error');
      }
    }));
  }
}
