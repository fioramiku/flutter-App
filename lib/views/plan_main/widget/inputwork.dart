import 'dart:developer';

import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class Inputwork extends StatelessWidget {
  TextEditingController constarttime = TextEditingController();
  TextEditingController conendtime = TextEditingController();
  TextEditingController contitle = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool checkopenclock = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimemanageBloc, TimemanageState>(
        builder: (context, state) {
      
        TimeOfDay BegintimeOfDay = TimeOfDay.now();
        TimeOfDay EndtimeOfDay = TimeOfDay.now();
        Color selectColor = Color.fromRGBO(244, 67, 54, 1);
        Future<TimeOfDay> _selectTime(BuildContext context, String helptext,
            TimeOfDay initialtime) async {
          final TimeOfDay? timeOfDay = await showTimePicker(
            helpText: helptext,
            context: context,
            initialTime: initialtime,
            initialEntryMode: TimePickerEntryMode.dial,
          );
          if (timeOfDay != null && timeOfDay != TimeOfDay.now()) {
            return timeOfDay;
          } else {
            return TimeOfDay.now();
          }
        }

        void _selectColor() {
          Color? colors;
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Pick Color"),
                  content: SingleChildScrollView(
                      child: BlockPicker(
                          pickerColor: Colors.red,
                          onColorChanged: (Color color) {
                            selectColor = color;
                          })),
                  actions: [
                    TextButton(
                        onPressed: () {
                          log(selectColor.toString());
                          Navigator.of(context).pop();
                        },
                        child: Text("Pick"))
                  ],
                );
              });
        }

        return Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: allcolors[0]),
          child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w200),
                      controller: contitle,
                      decoration: InputDecoration(
                        labelText: "Title",
                        filled: true,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _selectColor();
                            },
                            icon: Icon(
                              Icons.color_lens,
                            )),
                        IconButton(
                            onPressed: () async {
                              TimeOfDay initialtime = TimeOfDay.now();
                              BegintimeOfDay = await _selectTime(
                                  context, "StartTime", initialtime);
                              EndtimeOfDay = await _selectTime(
                                  context, "EndTime", BegintimeOfDay);
                              checkopenclock = true;
                            },
                            icon: Icon(Icons.av_timer)),
                        TextButton(
                            onPressed: () {
                              if (formkey.currentState!.validate() &&
                                  checkopenclock) {
                                context.read<TimemanageBloc>().add(Changeclock(
                                    day: state.selectday,
                                    newmodels: models_clock(
                                        title: contitle.text,
                                        starttime: BegintimeOfDay,
                                        endtime: EndtimeOfDay,
                                        color: selectColor)));

                                return Navigator.pop(context);
                              } else {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: SingleChildScrollView(
                                          child: ListBody(
                                        children: [
                                          Text("Please Check databefore!!!")
                                        ],
                                      )),
                                      actions: [
                                        TextButton(
                                            onPressed: (() =>
                                                Navigator.of(context).pop()),
                                            child: Text(
                                              "close",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(
                              "save",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    )
                  ],
                ),
              )),
        );
    
      }
    );
  }
}
