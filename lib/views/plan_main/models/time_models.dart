import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class models_clock extends Equatable {
  final TimeOfDay starttime;
  final TimeOfDay endtime;
  final String title;
  final Color color;
  final String status;
  final int worktool;
  late final  double timelength;
  models_clock(
      {required this.starttime,
      required this.title,
      required this.endtime,
      required this.color,
      this.status = "none",
      this.worktool = 0}) {
    if(endtime.hour>starttime.hour){
      timelength = ((endtime.hour - starttime.hour)*60).toDouble()+(endtime.hour-starttime.minute);
    }
    else if(endtime.hour<starttime.hour){
      timelength=((starttime.hour - endtime.hour)*60).toDouble()+(starttime.hour-endtime.minute);
    }
    else{
      if(endtime.minute>starttime.minute){

      }
    }
    
    
  }

  @override
  List<Object> get props => [starttime, endtime, title, color, status];
}
