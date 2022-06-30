import 'package:abc/views/home_page/widget_tool/time_separate/time_separate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../plan_main/bloc/timemanage_bloc.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  //stuck tool
  List<Widget> toolwidget = [Timeseparate_tool()];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimemanageBloc, TimemanageState>(
      builder: (context, state) {
        Widget checktool({required int toolnum}) {
          return toolwidget[toolnum];
        }

        return Scaffold(
            body: Center(
          child: Column(
            children: [
              checktool(toolnum: 0),
              ElevatedButton(
                onPressed: () {},
                child: Text("Reading"),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              )
            ],
          ),
        ));
      },
    );
  }
}
