import 'dart:developer';

import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
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
    return BlocBuilder<TimemanageBloc, TimemanageState>(
      builder: (context, state) {
        if (state.checkstate) {
          return ListView.separated(
            separatorBuilder: ((context, index) => const Divider(
                  height: 1,
                )),
            itemBuilder: ((context, index) {
              log("cardload");
              return InkWell(
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
                              color: Colors.blue, shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "${state.mclock[index].starttime}",
                                style: TextStyle(fontSize: 12),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "${state.mclock[index].starttime}",
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
            itemCount: state.mclock.length,
          );
        } else {
          log("end");
          return Text("NoneData---");
        }
      },
    );
  }
}
