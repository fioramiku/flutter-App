import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Changedata extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  models_clock model;

  Changedata({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Data page",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: BlocBuilder<TimemanageBloc, TimemanageState>(
          builder: (context, state) {
        return Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Data",
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                  TextField(
                      controller: title..text = model.title,
                      showCursor: false,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: "Change Data",
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                      )),
                  TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          
                         
                          context.read<TimemanageBloc>().add(Changeclock(
                            oldmodel:model,
                              changemodel: models_clock(starttime: model.starttime, title: title.text, endtime: model.endtime, color: model.color), day: state.selectday));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save"))
                ],
              ),
            ));
      }),
    );
  }
}
