import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class models_clock extends Equatable {
  final TimeOfDay starttime;
  final TimeOfDay endtime;
  final String title;
  models_clock({required this.starttime,required this.title,required this.endtime});

  @override
  List<Object> get props => [starttime,endtime,title];
}
