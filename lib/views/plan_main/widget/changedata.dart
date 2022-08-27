import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Changedata extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Data page",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
      ),
      body: BlocBuilder<TimemanageBloc, TimemanageState>(
          builder: (context, state) {
        return Form(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Data",style: Theme.of(context).textTheme.titleLarge!,),
              TextField(
                controller: title,
                showCursor: false,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  
                    labelText: "Change Data",
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    
              ))
            ],
          ),
        ));
      }),
    );
  }
}
