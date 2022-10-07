import 'dart:developer';
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:abc/views/plan_main/widget/changedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Workroad extends StatefulWidget {
  const Workroad({Key? key}) : super(key: key);

  @override
  State<Workroad> createState() => _WorkroadState();
}

class _WorkroadState extends State<Workroad> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimemanageBloc, TimemanageState>(
      buildWhen: ((previous, current) => true),
      builder: (context, state) {
        if (state is BuildClockState) {
          log("buildroad");
          final List<models_clock> uselist =
              state.mclock![state.selectday] ?? [];

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: ((_, index) {
                    //rebuild force
                    return childList(
                        model: uselist[index],
                        context: context,
                        selectday: state.selectday);
                  }),
                  itemCount: uselist.length,
                ),
              )
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

Widget childList(
    {required models_clock model,
    required BuildContext context,
    required DateTime selectday}) {
  return Card(
    child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: Container(
        width: 20,
        decoration: BoxDecoration(color: model.color, shape: BoxShape.circle),
      ),
      title: Text( model.title),
      subtitle: RichText(
          text: TextSpan(
              text: "",
              style: Theme.of(context).textTheme.labelSmall,
              children: <TextSpan>[
            TextSpan(
                text: model.starttime.format(context) +
                    " ~ " +
                    model.endtime.format(context))
          ])),
      trailing: IconButton(
          onPressed: () {
            context
                .read<TimemanageBloc>()
                .add(Deleteclock(models: model, daySelect: selectday));
          },
          icon: const Icon(Icons.settings)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Changedata(
            model: model,
            selectday:selectday
          );
        }));
      },
    ),
  );
}

        /*
          //calcute length
          int makestream({required TimeOfDay positiontime}) {
            final DateTime nowtime = DateTime.now();P
            final int nowsec =
                nowtime.hour * 3600 + nowtime.minute * 60 + nowtime.second;
            final int pointsec = state.con2min(timeOfDay: positiontime) * 60;
            final int length = pointsec - nowsec;
            if (length > 0) {
              return (length);
            } else if (length < 0) {
              return (86400 + length);
            } else {
              return 0;
            }
          }

          int checkall() {
            int all = 86400;

            for (int i = 0; i < uselist.length; i++) {
              int num = makestream(positiontime: uselist[i].starttime);
              if (all >= num) {
                all = num;
              }
            }
            return all;
          }
          */
