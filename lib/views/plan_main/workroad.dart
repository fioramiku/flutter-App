import 'dart:developer';

import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Workroad extends StatefulWidget {
  const Workroad({Key? key}) : super(key: key);

  @override
  State<Workroad> createState() => _WorkroadState();
}

class _WorkroadState extends State<Workroad> {
  @override
  Widget build(BuildContext context) {
    log("rebuild");
    return BlocBuilder<TimemanageBloc, TimemanageState>(
      builder: (context, state) {
        //calcute length
        int makestream({required TimeOfDay positiontime}) {
          final DateTime nowtime = DateTime.now();
          final int nowsec =
              nowtime.hour * 3600 + nowtime.minute * 60 + nowtime.second;
          final int pointsec = state.con2min(timeOfDay: positiontime) * 60;
          if (pointsec > nowsec) {
            return (pointsec - nowsec);
          } else if (pointsec < nowsec) {
            return (86400 - nowsec + pointsec);
          } else {
            return 0;
          }
        }

        final TimeOfDay now = TimeOfDay.now();

        List<models_clock> uselist =
            state.ordertime(models: state.mclock, now: now);

        return ListView.separated(
          separatorBuilder: ((context, index) => const Divider(
                height: 1,
              )),
          itemBuilder: ((context, index) {
            log(makestream(positiontime: uselist[0].starttime).toString());
            //rebuild
            Future.delayed(
                Duration(
                    seconds: makestream(positiontime: uselist[0].endtime)),
                () {
              log("future");
              setState(() {
                
              });;
            });
            log("cardload");
            return InkWell(
              //input card
              onTap: () {},
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        decoration: BoxDecoration(
                            color: uselist[index].color,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "${uselist[index].starttime}",
                              style: TextStyle(fontSize: 12),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "${uselist[index].endtime}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          itemCount: uselist.length,
        );
      },
    );
  }
}
