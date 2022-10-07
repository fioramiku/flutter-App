import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class models_clock extends Equatable {
  final TimeOfDay starttime;
  final TimeOfDay endtime;
  final String title;
  final Color color;
  final String status;
  final int worktool;
  late final double timelength;
  final int statusIndex; //0 => unfinish ,1=> working ,2 => finish
  final bool check;

  int get stateIndex => statusIndex;
  set stateIndex(int index) => index;

   models_clock(
      {required this.starttime,
      required this.title,
      required this.endtime,
      required this.color,
      this.check = true,
      this.status = "none",
      this.statusIndex = 0,
      this.worktool = 0});
  @override
  List<Object> get props =>
      [starttime, endtime, title, color, status, statusIndex];

  Map<String, dynamic> toMap() {
    return {
      'starttime': tod2str(starttime),
      'endtime': tod2str(endtime),
      'title': title,
      'color': color.value,
      'status': status,
      'worktool': worktool,
      
      'statusIndex': statusIndex,
      'check': check
    };
  }

  factory models_clock.formMap(Map<String, dynamic> map) {
    TimeOfDay str2tod(String time) => TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1]));

    return models_clock(
        starttime: str2tod(map['starttime']),
        endtime: str2tod(map['endtime']),
        title: map['title'],
        color: Color(map['color'] ),
        status: map['status'],
        worktool: map['worktool'],
        statusIndex: map['statusIndex'],
        check: map['check']);
  }

  String tod2str(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }
}
