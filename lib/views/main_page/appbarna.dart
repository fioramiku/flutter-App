import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Appbar_Change {
  String title;
  dynamic lead;
  List<Widget> action_button;
  int sized = 0;
  bool time_check;
  Appbar_Change(
      {this.title = '',
      this.lead = null,
      this.action_button = const [],
      this.time_check = false}) {
    this.sized = this.action_button.length;
  }
}

AppBar buildWG({
  required List<Appbar_Change> appbar,
  required int selectIndex,
}) {
  AppBar appBar = AppBar(
    
   
    toolbarHeight: 40,
    title: Row(
      children: [
        Text(appbar[selectIndex].title),
        if (appbar[selectIndex].time_check) ...[
          const Flexible(child: SizedBox(), fit: FlexFit.tight),
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (_,__) {
              
              return Text(DateFormat('HH:mm:ss').format(DateTime.now()));
            },
          )
        ]
      ],
    ),
    leading: appbar[selectIndex].lead,
    actions: appbar[selectIndex].action_button,
    elevation: 0,
    bottomOpacity: 0,
  );
  return appBar;
}

Widget build_action({required Widget icon, Function()? function}) {
  return Padding(
      padding: EdgeInsets.only(right: 2),
      child: IconButton(onPressed: function, icon: icon));
}

Widget build_leading({required Widget icon, Function()? function}) {
  return IconButton(onPressed: function, icon: icon);
}
