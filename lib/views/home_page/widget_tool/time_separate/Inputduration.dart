import 'package:abc/views/home_page/widget_tool/time_separate/bloc/separate_bloc.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/timeseparate_models.dart';
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: must_be_immutable
class Inputduration extends StatefulWidget {
  Inputduration({
    Key? key,
  }) : super(key: key);

  @override
  State<Inputduration> createState() => _InputdurationState();
}

class _InputdurationState extends State<Inputduration> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final _maxloopnum = 5;

  final Duration _intialduration = Duration(seconds: 30);
  Duration? _sectiontime;
  Duration? _breaktime;
  int _loopnum = 0;
  formatDuration(Duration? d) => (d != null)
      ? d.toString().split('.').first.padLeft(8, "0")
      : Duration(seconds: 0).toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimemanageBloc, TimemanageState>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(15)),
        child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "create Models Time",
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),SizedBox(
                    height: 10,
                  ),
                  TextField(
                      autofocus: true,
                      onTap: () async {
                        _sectiontime = await showDurationPicker(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).dialogBackgroundColor),
                            context: context,
                            initialTime: _intialduration);
                        setState(() {
                          _sectiontime = _sectiontime;
                        });
                      },
                      controller: TextEditingController()
                        ..text = formatDuration(_sectiontime),
                      showCursor: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hoverColor: Color.fromARGB(104, 193, 193, 193),
                        fillColor: Color.fromARGB(114, 234, 234, 234),
                        filled: true,
                        labelText: "Section Time",
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                      )),
                  TextField(
                      autofocus: true,
                      onTap: () async {
                        _breaktime = await showDurationPicker(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).dialogBackgroundColor),
                            context: context,
                            initialTime: _intialduration);
                        setState(() {
                          _breaktime = _breaktime;
                        });
                      },
                      controller: TextEditingController()
                        ..text = formatDuration(_breaktime),
                      showCursor: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        hoverColor: Color.fromARGB(104, 193, 193, 193),
                        fillColor: Color.fromARGB(114, 234, 234, 234),
                        filled: true,
                        labelText: "Section Time",
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("select Loop"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(10)),
                    child: NumberPicker(
                      itemHeight: 50,
                      itemWidth: MediaQuery.of(context).size.width/4,
                        axis: Axis.horizontal,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black26),
                        ),
                        minValue: 0,
                        maxValue: _maxloopnum,
                        value: _loopnum,
                        onChanged: (num) {
                          setState(() {
                            _loopnum = num;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => setState(() {
                          final newValue = _loopnum - 1;
                          _loopnum = newValue.clamp(0, _maxloopnum);
                        }),
                      ),
                      Text('Current int value: $_loopnum'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => setState(() {
                          final newValue = _loopnum + 1;
                          _loopnum = newValue.clamp(0, _maxloopnum);
                        }),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          context.read<SeparateBloc>().add(InitialSeparate(
                              models: TimeseparateModels(
                                  breaktime: _breaktime,
                                  sectiontime: _sectiontime,
                                  looptime: _loopnum)));

                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save"))
                ],
              ),
            )),
      );
    });
  }
}
