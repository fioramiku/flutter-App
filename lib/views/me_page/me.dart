import 'dart:math';
import 'package:abc/database/base_data_tool.dart';

import 'package:abc/views/me_page/bloc/profile_bloc.dart';
import 'package:abc/views/me_page/cubit/chart_cubit.dart';
import 'package:abc/views/me_page/data.dart';
import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Me_page extends StatefulWidget {
  const Me_page({Key? key}) : super(key: key);

  @override
  State<Me_page> createState() => _Me_pageState();
}

class _Me_pageState extends State<Me_page> {
  List<Niles> names = [
    Niles("Account", "assets/images/cover.png"),
    Niles("Setting", "assets/images/cover.png"),
    Niles("Help Center", "assets/images/cover.png")
  ];

  int touchedIndex = -1;

  @override
  void initState() {
    context.read<ChartCubit>().chartInitialEvent();
    context.read<ProfileBloc>().add(Initial_Profile_Event());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        dynamic fileimage = (state.image == null)
            ? NetworkImage(
                "https://w7.pngwing.com/pngs/532/849/png-transparent-user-person-people-profile-account-human-avatar-administrator-worker-employee.png")
            : FileImage(state.image!);
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          ClipPath(
            clipper: ClipPathClass(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Column(children: [
                CircleAvatar(
                  backgroundImage: fileimage,
                  backgroundColor: Colors.yellowAccent,
                  radius: 50,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '${state.name}',
                )
              ]),
            ),
          ),
          Expanded(
              flex: 0,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tasking"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Theme.of(context).indicatorColor,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        height: MediaQuery.of(context).size.height / 7,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(context.select((TodolistBloc bloc) =>
                                  (bloc.state is BuildTodoState)
                                      ? bloc.state.model
                                          .where((element) =>
                                              element.finish == false)
                                          .length
                                          .toString()
                                      : ""))),
                        ),
                      ),
                    ],
                  ))),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Theme.of(context).indicatorColor,
                      width: 5,
                    )),
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Align(
                          alignment: Alignment.center,
                          child: Text('Task Chart weeks')),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: BlocBuilder<ChartCubit, ChartState>(
                          builder: (_, state) {
                            return BarChart(
                              mainBarData(state: state),
                              swapAnimationDuration:
                                  Duration(milliseconds: 150), // Optional
                              swapAnimationCurve: Curves.linear, // Optional
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          )
        ]);
      },
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 18,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Theme.of(context).indicatorColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Theme.of(context).indicatorColor, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Theme.of(context).splashColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(ChartState state) =>
      List.generate(7, (i) {
        double setValue(int i) =>
            (state is ChartBuildState) ? state.data[i.toString()] ?? 0 : 0;

        switch (i) {
          case 0:
            return makeGroupData(0, setValue(i), isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, setValue(i), isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, setValue(i), isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, setValue(i), isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, setValue(i), isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, setValue(i), isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, setValue(i), isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData({required ChartState state}) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(state),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Theme.of(context).indicatorColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('M', style: style);
        break;
      case 1:
        text = Text('T', style: style);
        break;
      case 2:
        text = Text('W', style: style);
        break;
      case 3:
        text = Text('T', style: style);
        break;
      case 4:
        text = Text('F', style: style);
        break;
      case 5:
        text = Text('S', style: style);
        break;
      case 6:
        text = Text('S', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
