import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;
import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/Inputduration.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/bloc/separate_bloc.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/timeseparate_models.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Timeseparate_tool extends StatefulWidget {
  const Timeseparate_tool({Key? key}) : super(key: key);

  @override
  State<Timeseparate_tool> createState() => _Timeseparate_toolState();
}

class _Timeseparate_toolState extends State<Timeseparate_tool> {
  final TimeseparateModels _models = TimeseparateModels(
      sectiontime: Duration(minutes: 3),
      breaktime: Duration(minutes: 3),
      looptime: 3);

  formatDuration(Duration? d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    final models = context.select((SeparateBloc bloc) => bloc.state.models);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       
        SizedBox(
          height: MediaQuery.of(context).size.height / 27,
        ),
        Stack(alignment: Alignment.topCenter, children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: BlocBuilder<SeparateBloc, SeparateState>(
                builder: ((context, state) => CircularPercentIndicator(footer: Text(state.toString()),
                  
                      reverse: false,
                      radius: MediaQuery.of(context).size.height * 0.18,
                      lineWidth: 13.0,
                      animation: true,
                      animateFromLastPercent: true,
                      percent: (state is UsingSeparateState)
                          ? ((state.defaultmodels.sectiontime!.inSeconds -
                                  state.models.sectiontime!.inSeconds) /
                              state.defaultmodels.sectiontime!.inSeconds)
                          : (state is CooldownState)
                              ? (state.models.breaktime!.inSeconds /
                                  state.defaultmodels.breaktime!.inSeconds)
                              : 0,
                      center: Text(
                        '${(state is UsingSeparateState) ? formatDuration(state.models.sectiontime) : (state is CooldownState) ? formatDuration(state.models.breaktime) : 0}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: (state is UsingSeparateState)
                          ? Colors.orange
                          : Colors.blue,
                    ))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () => showModalBottomSheet(
                    context: context, builder: (ctx) => Inputduration()),
                icon: Icon(Icons.edit)),
          ),
        ]), SizedBox(
          height: MediaQuery.of(context).size.height / 23,
        ),
        widSeparate(),
      ],
    );
  }
}

Widget widSeparate() {
  return BlocBuilder<SeparateBloc, SeparateState>(builder: (context, state) {
    if (state is SeparateInitialState) {
      return TextButton(
          onPressed: () {
            context
                .read<SeparateBloc>()
                .add(StartSeparate(models: state.models));
          },
          child: Text("Reading"));
    } else if (state is UsingSeparateState) {
      return TextButton(
          onPressed: () {
            context
                .read<SeparateBloc>()
                .add(BuildSeperate(models: state.models));
          },
          child: Text("Stop"));
    } else {
      return SizedBox();
    }
  });
}
