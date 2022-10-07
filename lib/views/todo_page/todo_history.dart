import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';
import 'package:abc/views/todo_page/todo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoHistory extends StatefulWidget {
  const TodoHistory({Key? key}) : super(key: key);

  @override
  State<TodoHistory> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodolistBloc, TodolistState>(
      builder: (context, state) {
        final List<Todolist> uselist = state.model.where((element) => (element.finish!=null)?(element.finish!):false).toList();
        uselist.sort(((a, b) => a.finishDate!.compareTo(b.finishDate!)));
        return ListView.builder(
            itemCount: uselist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                    subtitle:
                        Text(uselist[index].deadlineTime.format(context)),
                    trailing: Icon(Icons.lock_clock_outlined),
                    tileColor: Theme.of(context).appBarTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(uselist[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white))),
              );
            });
      },
    );
  }
}
