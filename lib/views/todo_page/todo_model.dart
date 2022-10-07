import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Todolist extends Equatable {
  final TimeOfDay deadlineTime;
  final DateTime deadlineDate;
  final String title;
  final DateTime? finishDate;
  final bool? finish;

  bool? get check => finish;

  set check(bool? ckbool) => finish;

  const Todolist(
      {required this.deadlineTime,
      required this.title,
      required this.deadlineDate,
      this.finishDate,
      this.finish = false});

  @override
  List<Object?> get props => [deadlineTime, deadlineDate, title,finish];



  Map<String, dynamic> toMap() {
    return {
      'finish': finish,
      'deadtime': tod2str(deadlineTime),
      'deaddate': deadlineDate.toString(),
      'title': title,
      'finishdate': finishDate
    };
  }

  factory Todolist.copyTodo({TimeOfDay? deadlineTime,
  DateTime? deadlineDate,
   String? title,
   DateTime? finishDate,
  bool? finish,required Todolist todo}){
    return Todolist(deadlineTime: deadlineTime??todo.deadlineTime ,title: title??todo.title, deadlineDate: deadlineDate??todo.deadlineDate,finish: finish??todo.finish);
  }

  factory Todolist.fromMap(Map<String, dynamic> map) {
    TimeOfDay str2tod(String time) => TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1]));
    print("mapvalues" + map.values.toString());
    if (map != null) {
      return Todolist(
          finish: map['finish'],
          finishDate: (map['finishdate']!=null)?map['finishdate']:null,
          deadlineTime: str2tod(map['deadtime']),
          title: map['title'],
          deadlineDate: DateTime.parse(map['deaddate']));
    } else {
      return Todolist(
          deadlineTime: TimeOfDay.now(),
          title: 'Null',
          deadlineDate: DateTime.now());
    }
  }

  String tod2str(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }
}
