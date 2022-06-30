import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/chatbot/Chatbot_page.dart';

import 'package:abc/views/home_page/home_main.dart';

import 'package:abc/views/main_page/appbarna.dart';
import 'package:abc/views/me_page/data.dart';
import 'package:abc/views/me_page/me.dart';
import 'package:abc/views/plan_main/Plan_main.dart';
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../database/Transection_data.dart';

import '../me_page/bloc/profile_bloc.dart';

class Basic_mainpage extends StatelessWidget {
  const Basic_mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profilebloc = BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
    );
    final clockbloc = BlocProvider<TimemanageBloc>(
      create: (context) => TimemanageBloc(),
    );

    return MultiBlocProvider(
      providers: [
        profilebloc,
        clockbloc
      ],
      child: MaterialApp(
        title: "fiat",
        home: Nagative_button(),
        color: allcolors[0],
        theme:maintheme(),
      ),
    );
  }
}

class Nagative_button extends StatefulWidget {
  const Nagative_button({Key? key}) : super(key: key);

  @override
  State<Nagative_button> createState() => _Nagative_buttonState();
}
  
class _Nagative_buttonState extends State<Nagative_button> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(Initial_Profile_Event());
    super.initState();
  }
  static int selectIndex = 0;

 
  List<dynamic> page = [Home_page(), chat_page(), Me_page(),Chatbot()];

  @override
  Widget build(BuildContext context) {
    List<Appbar_Change> Using = [
      Appbar_Change(
          title: "Home",
          lead: build_leading(
              icon: Icon(Icons.home),
              function: () {
                print('open home');
              }),
          action_button: [
            build_action(
                icon: Icon(Icons.add),
                function: () {
                  print('add');
                }),
            build_action(
                icon: Icon(Icons.find_in_page),
                function: () {
                  print('find');
                })
               
          ]),
      Appbar_Change(
          title: "Plan",
          action_button: [build_action(icon: Icon(Icons.add))],
          time_check: true),
      Appbar_Change(title: "Me", action_button: [
        build_action(
            icon: Icon(Icons.settings),
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Setting_pagena();
              }));
            })
      ]),Appbar_Change(title: "chatbot")
    ];

    return Scaffold(
      appBar: buildWG(appbar: Using, selectIndex: selectIndex),
      body: page[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: Change_Page,
        selectedItemColor: allcolors[0],
        unselectedItemColor: Color.fromARGB(31, 0, 204, 255),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: "chatbot")
        ],
        currentIndex: selectIndex,
      ),
    );
  }

  void Change_Page(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
