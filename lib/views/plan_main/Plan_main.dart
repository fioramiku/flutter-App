import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/clock.dart';
import 'package:abc/views/plan_main/widget/calendar.dart';
import 'package:abc/views/plan_main/widget/inputwork.dart';
import 'package:abc/views/plan_main/workroad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class chat_page extends StatefulWidget {
  const chat_page({Key? key}) : super(key: key);

  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();
  TextEditingController constarttime = TextEditingController();
  TextEditingController conendtime = TextEditingController();
  TextEditingController contitle = TextEditingController();
  int widgetchange = 0;
  List<Widget> widgetuse = [mainClock(), const Calendar()]; //widgeat changeable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => showBottomSheet(
                context: context,
                builder: (_) {
                  return Inputwork(); //add event
                })),
        body: Column(
          children: [
            Stack(
              children: [
                widgetuse[widgetchange],
                if(widgetchange==0)...{
                  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Text("changeclock"),
                      IconButton(
                          onPressed: () => setState(() {
                                if (widgetchange == 0) {
                                  widgetchange = 1;
                                } else {
                                  widgetchange = 0;
                                }
                              }),
                          icon: const Icon(Icons.change_circle_outlined,
                              color: Colors.black, size: 28)),
                    ],
                  ),
                }

                
              ],
            ),
            if(widgetchange==1)...{
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Text("changeclock"),
                      IconButton(
                          onPressed: () => setState(() {
                                if (widgetchange == 0) {
                                  widgetchange = 1;
                                } else {
                                  widgetchange = 0;
                                }
                              }),
                          icon: const Icon(Icons.change_circle_outlined,
                              color: Colors.black, size: 28)),
                    ],
                  ),
                
            },
            const Expanded(child: Workroad()),
            
          ],
        ));
  }
}

Widget mainClock() {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
                top: Radius.zero, bottom: Radius.circular(8)),
            color: allcolors[0]),
        alignment: Alignment.bottomCenter,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Clockplan(),
        ),
      ),
      BlocBuilder<TimemanageBloc, TimemanageState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    context.read<TimemanageBloc>().add(Changeday(
                        focusday:
                            state.selectday.add(const Duration(days: -1))));
                  },
                  icon: const Icon(Icons.arrow_left,color: Colors.black,)),
              Container(
                child: Text(
                  DateFormat('dd/MM/yyyy').format(state.selectday),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 17),
                ),
                decoration:
                    BoxDecoration(color: Theme.of(context).backgroundColor,borderRadius: BorderRadius.circular(8)),
                    
              ),
              IconButton(
                  onPressed: () {
                    context.read<TimemanageBloc>().add(Changeday(
                        focusday:
                            state.selectday.add(const Duration(days: 1))));
                  },
                  icon: const Icon(
                    Icons.arrow_right,
                    color: Colors.black,
                  )),
            ],
          );
        },
      )
    ],
  );
}
