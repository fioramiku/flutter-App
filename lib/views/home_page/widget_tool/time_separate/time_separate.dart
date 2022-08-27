import 'dart:collection';
import 'dart:math' as math;
import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/bloc/separate_bloc.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/timeseparate_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Timeseparate_tool extends StatefulWidget {
  const Timeseparate_tool({Key? key}) : super(key: key);

  @override
  State<Timeseparate_tool> createState() => _Timeseparate_toolState();
}

class _Timeseparate_toolState extends State<Timeseparate_tool> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width/3,
                decoration: BoxDecoration(color: Color(0xFFf8b195),
            
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: AspectRatio(
                  aspectRatio: 3/2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('${context.select((SeparateBloc bloc) {
                      if (bloc.state is UsingSeparateState) {
                        return bloc.state.models.sectiontime;
                      }
                    })}',style: TextStyle(fontSize:math.min(MediaQuery.of(context).size.width/8,MediaQuery.of(context).size.height/8),),
                  ),
                ),
              ),
            ),
          ),),widSeparate()
          
        ],
      ),
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
          child: Text("Reading"));
    } else {
      return SizedBox();
    }
  });
}
