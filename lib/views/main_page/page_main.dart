import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/chatbot/Chatbot_page.dart';

import 'package:abc/views/home_page/home_main.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/bloc/separate_bloc.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/bloc/separate_bloc.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/ticker.dart';

import 'package:abc/views/main_page/appbarna.dart';
import 'package:abc/views/main_page/cubit/theme_dart_cubit.dart';
import 'package:abc/views/me_page/cubit/chart_cubit.dart';
import 'package:abc/views/me_page/data.dart';
import 'package:abc/views/me_page/me.dart';
import 'package:abc/views/plan_main/Plan_main.dart';
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';
import 'package:abc/views/todo_page/todo_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../database/Transection_data.dart';

import '../home_page/widget_tool/time_separate/bloc/separate_bloc.dart';
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
    final separateBloc = BlocProvider<SeparateBloc>(
        create: (context) => SeparateBloc(ticker: const Ticker()));
    final todoBloc = BlocProvider<TodolistBloc>(
      create: (context) => TodolistBloc(),
    );
    final CtCubit =
        BlocProvider<ChartCubit>(create: ((context) => ChartCubit()));
    final ThemeCubit = BlocProvider<ThemeDartCubit>(
      create: ((context) => ThemeDartCubit()),
    );

    return MultiBlocProvider(
        providers: [
          profilebloc,
          clockbloc,
          separateBloc,
          todoBloc,
          CtCubit,
          ThemeCubit
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              title: "fiat",
              home: Nagative_button(),
              theme: (context.watch<ThemeDartCubit>().state)
                  ? darkTheme()
                  : lightTheme(),
            );
          }
        ));
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

  final List<int> _emptyApp = [];

  static int selectIndex = 0;

  List<dynamic> page = const [
    Home_page(),
    TodoPage(),
    chat_page(),
    Me_page(),
    Chatbot()
  ];

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
      Appbar_Change(title: "todo"),
      Appbar_Change(
          title: "Plan",
          action_button: [build_action(icon: const Icon(Icons.add))],
          time_check: true),
      Appbar_Change(title: "Me", action_button: [
        build_action(
            icon: const Icon(Icons.settings),
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Setting_pagena();
              }));
            })
      ]),
      Appbar_Change(title: "chatbot")
    ];

    return Scaffold(
      appBar: (!_emptyApp.contains(selectIndex))
          ? buildWG(appbar: Using, selectIndex: selectIndex)
          : null,
      body: page[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: Change_Page,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Todo"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Mine"),
        //  BottomNavigationBarItem(icon: Icon(Icons.chat), label: "chatbot")
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
