import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  State<TodoView> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodolistBloc, TodolistState>(
      builder: (context, state) {
        return ReorderableListView.builder(
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
            newIndex -= 1;
          }
              context
                  .read<TodolistBloc>()
                  .add(SwapTodoEvent(oldindex: oldIndex, newindex: newIndex));
            },
            itemCount: state.model.length,
            itemBuilder: (context, index) {
              return Padding(
                key: Key('${index}'),
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                    subtitle:
                        Text(state.model[index].deadlineTime.format(context)),
                    trailing: IconButton(
                      onPressed: () => context
                          .read<TodolistBloc>()
                          .add(DeletetodoEvent(model: state.model[index])),
                      icon: Icon(Icons.delete),
                    ),
                    tileColor: Theme.of(context).appBarTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(state.model[index].title,
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
