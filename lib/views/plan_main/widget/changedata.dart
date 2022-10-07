import 'dart:developer';

import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Changedata extends StatefulWidget {
  final models_clock model;
  final DateTime selectday;

  const Changedata({Key? key, required this.model, required this.selectday})
      : super(key: key);

  @override
  State<Changedata> createState() => _ChangedataState();
}

class _ChangedataState extends State<Changedata> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();

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

  Future<Color> _selectColor() async {
    Color selectColor = Colors.red;
    await showDialog(
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
                    Navigator.of(context).pop();
                  },
                  child: Text("Pick"))
            ],
          );
        });
    return selectColor;
  }

  Color? _color;

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _isChange = false;

  @override
  Widget build(BuildContext context) {
    final model = widget.model;

    return BlocBuilder<TimemanageBloc, TimemanageState>(
        builder: (context, state) {
      var _list = makeList(context, model, widget.selectday);
      return Scaffold(
          appBar: AppBar(
            actions: (!_isChange)
                ? []
                : [
                    IconButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            if (state is BuildClockState) {
                              context.read<TimemanageBloc>().add(Changeclock(
                                  oldmodel: model,
                                  changemodel: changeData(
                                    color: _color,
                                      model: model,
                                      title: title.text,
                                      starttime: _startTime,
                                      endtime: _endTime),
                                  day: widget.selectday));
                              Navigator.pop(context);
                            }
                          }
                        },
                        icon: Icon(Icons.check))
                  ],
            toolbarHeight: 40,
            elevation: 0,
          ),
          body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                        onSubmitted: (_) {
                          setState(() {
                            _isChange = true;
                          });
                        },
                        style: Theme.of(context).textTheme.titleLarge,
                        controller: title..text = model.title,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: "title",
                          labelStyle: Theme.of(context).textTheme.titleSmall,
                        )),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return _list[index];
                          },
                          separatorBuilder: (_, __) => const Divider(
                                height: 1,
                              ),
                          itemCount: _list.length),
                    ),
                  ],
                ),
              )));
    });
  }

  InkWell listTile(
      Icon icon, String title, Widget trail, void Function()? func) {
    return InkWell(
        onTap: func,
        child: ListTile(leading: icon, title: Text(title), trailing: trail));
  }

  List<Widget> makeList(
          BuildContext context, models_clock model, DateTime day) =>
      <Widget>[
        listTile(const Icon(Icons.calendar_month), "startTime",
            Text((_startTime ?? model.starttime).format(context)), () async {
          var time = await _selectTime(
              context, "startTime", _startTime ?? model.starttime);
          setState(() {
            _startTime = time;
            _isChange = true;
          });
          log("${_startTime ?? model.starttime}");
        }),
        listTile(Icon(Icons.lock_clock), "endTime",
            Text((_endTime ?? model.endtime).format(context)), () async {
          var time = await _selectTime(
              context, "startTime", _endTime ?? model.starttime);
          setState(() {
            _endTime = time;
            _isChange = true;
          });
        }),
        listTile(
            Icon(Icons.color_lens),
            "Color",
            Container(
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _color ?? model.color)), () async {
          var color = await _selectColor();
          setState(() {
            _color = color;
            _isChange = true;
          });
        })
      ];
  models_clock changeData(
      {TimeOfDay? starttime,
      String? title,
      TimeOfDay? endtime,
      Color? color,
      bool? check,
      String? status,
      int? statusIndex,
      int? worktool,
      required models_clock model}) {
    return models_clock(
        starttime: starttime ?? model.starttime,
        title: title ?? model.title,
        endtime: endtime ?? model.endtime,
        color: color ?? model.color,
        check: check ?? model.check,
        status: status ?? model.status,
        statusIndex: statusIndex ?? model.stateIndex,
        worktool: worktool ?? model.worktool);
  }
}
