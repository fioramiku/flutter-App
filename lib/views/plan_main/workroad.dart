
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
        log("buildroad");
        final TimeOfDay now = TimeOfDay.now();
        final List<models_clock> uselist = state.mclock![state.selectday] ?? [];

        return Column(
          children: [
            
            Expanded(
              child: ListView.separated(
                separatorBuilder: ((_, __) => const Divider(
                      height: 1,
                    )),
                itemBuilder: ((_, index) {
                  //rebuild force
                  return InkWell(
                    //route page
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Changedata();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: (uselist[index].statusIndex == 1)
                          ? Colors.red
                          : Colors.blue,),
                     
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
                            const SizedBox(
                              width: 10,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "${uselist[index].starttime}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "${uselist[index].endtime}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Flexible(
                                child: SizedBox(), fit: FlexFit.tight),
                            IconButton(
                                onPressed: () {
                                  context.read<TimemanageBloc>().add(
                                      Deleteclock(
                                          models: uselist[index],
                                          daySelect: state.selectday));
                                },
                                icon: const Icon(Icons.settings))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                itemCount: uselist.length,
              ),
            )
          ],
        );
      },
    );
  }
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
