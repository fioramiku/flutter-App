import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class models_clock extends Equatable {
  final TimeOfDay starttime;
  final TimeOfDay endtime;
  final String title;
  final Color color;
  models_clock(
      {required this.starttime,
      required this.title,
      required this.endtime,
      required this.color});

  @override
  List<Object> get props => [starttime, endtime, title, color];
}
