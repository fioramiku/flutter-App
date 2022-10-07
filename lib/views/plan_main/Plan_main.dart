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
  @override
  void initState() {
    context.read<TimemanageBloc>().add(InitialClockEvent());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();
  TextEditingController constarttime = TextEditingController();
  TextEditingController conendtime = TextEditingController();
  TextEditingController contitle = TextEditingController();
  int widgetchange = 0;
  int muneindex = 0;
  //widgeat changeable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => showBottomSheet(
                context: context,
                builder: (_) {
                  return Inputclockwork(); //add event
                })),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            if (widgetchange == 0) ...{
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.foregroundColor),
                alignment: Alignment.bottomCenter,
                child: Clockplan(),
              ),
            } else if (widgetchange == 1) ...{
              const Calendar(),
            },
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (widgetchange == 0) ...{
                    timeNext(),
                  } else ...{
                    Flexible(
                      child: SizedBox(),
                      fit: FlexFit.tight,
                    ),
                    IconButton(
                        tooltip: "ChangeClock",
                        onPressed: () => setState(() {
                              if (widgetchange == 0) {
                                widgetchange = 1;
                              } else {
                                widgetchange = 0;
                              }
                            }),
                        icon: const Icon(Icons.change_circle_outlined,
                            color: Colors.black, size: 28)),
                  }
                ],
              ),
            ),
            const Expanded(child: Workroad()),
          ],
        ));
  }

  BlocBuilder<TimemanageBloc, TimemanageState> timeNext() {
    return BlocBuilder<TimemanageBloc, TimemanageState>(
      builder: (context, state) {
        if (state is BuildClockState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    context.read<TimemanageBloc>().add(Changeday(
                        focusday:
                            state.selectday.add(const Duration(days: -1))));
                  },
                  icon: const Icon(
                    Icons.arrow_left,
                    size: 25,
                  )),
              Container(
                child: Text(
                  DateFormat('dd/MM/yyyy').format(state.selectday),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 17),
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.read<TimemanageBloc>().add(Changeday(
                        focusday:
                            state.selectday.add(const Duration(days: 1))));
                  },
                  icon: const Icon(
                    Icons.arrow_right,
                  )),
              //change widget to calendar
              IconButton(
                  tooltip: "ChangeClock",
                  onPressed: () => setState(() {
                        if (widgetchange == 0) {
                          widgetchange = 1;
                        } else {
                          widgetchange = 0;
                        }
                      }),
                  icon: const Icon(Icons.change_circle_outlined, size: 28)),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
