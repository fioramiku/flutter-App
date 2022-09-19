import 'dart:developer';

import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';
import 'package:abc/views/todo_page/todo_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InputTodowork extends StatefulWidget {
  InputTodowork({Key? key}) : super(key: key);

  @override
  State<InputTodowork> createState() => _InputTodoworkState();
}

class _InputTodoworkState extends State<InputTodowork> {
  TextEditingController constarttime = TextEditingController();
  TextEditingController contitle = TextEditingController();
  final formkey = GlobalKey<FormState>();
  TimeOfDay selecttimeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  bool checkopenclock = false;
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<TodolistBloc, TodolistState>(builder: (context, state) {
      Future<TimeOfDay> _selectTime(
          BuildContext context, String helptext, TimeOfDay initialtime) async {
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

      Future<DateTime> _selectDate(BuildContext context) async {
        final selected = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
        );
        if (selected != null && selected != selectedDate) {
          return selected;
        } else {
          return selectedDate;
        }
      }

      return Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), ),
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
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      if (checkopenclock == true) ...{
                        
                        
                         InkWell( child: Container(decoration: BoxDecoration(color: Color.fromARGB(56, 103, 180, 218), borderRadius: BorderRadius.circular(5)),
                          child:Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(DateFormat('yyyy/MM/dd').format(selectedDate) +
                              '  ' +
                              selecttimeOfDay.format(context),style: TextStyle(color: Colors.white),),
                          )),onTap: () async {
                            TimeOfDay initialtime = TimeOfDay.now();
                            selecttimeOfDay = await _selectTime(
                                context, "StartTime", initialtime);
                            selectedDate = await _selectDate(context);
                            checkopenclock = true;
                            setState(() {
                              selectedDate = selectedDate;
                              selecttimeOfDay = selecttimeOfDay;
                            });
                          },)
                      }
                      else...{
                      
                      IconButton(
                          onPressed: () async {
                            TimeOfDay initialtime = TimeOfDay.now();
                            selecttimeOfDay = await _selectTime(
                                context, "StartTime", initialtime);
                            selectedDate = await _selectDate(context);
                            checkopenclock = true;
                            setState(() {
                              selectedDate = selectedDate;
                              selecttimeOfDay = selecttimeOfDay;
                            });
                          },
                          icon: Icon(Icons.av_timer)),},
                      TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate() &&
                                checkopenclock) {
                              context.read<TodolistBloc>().add(AddtodoEvent(
                                  model: Todolist(
                                      deadlineTime: selecttimeOfDay,
                                      deadlineDate: selectedDate,
                                      title: contitle.text)));

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
    });
  }
}
