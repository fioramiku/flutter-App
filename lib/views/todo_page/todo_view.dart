import 'dart:developer';

import 'package:abc/database/base_data_tool.dart';
import 'package:abc/views/me_page/cubit/chart_cubit.dart';
import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';
import 'package:abc/views/todo_page/todo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatefulWidget {
  final int numwid;
  const TodoView({Key? key, this.numwid = 0}) : super(key: key);

  @override
  State<TodoView> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoView> {
  var widnum = 0;
  bool press = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodolistBloc, TodolistState>(builder: (context, state) {
      if (state is BuildTodoState) {
        var uselist = makeList(widnum, state.model);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                chipMake("defualt", 0),
                chipMake("history", 1),
                chipMake("working", 2)
              ]),
            ),
            Expanded(
              child: ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    context.read<TodolistBloc>().add(
                        SwapTodoEvent(oldindex: oldIndex, newindex: newIndex));
                  },
                  itemCount: uselist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      key: Key('${index}'),
                      onLongPress: () {
                        log("press");
                        log(press.toString());
                        setState(() {
                          press = true;
                        });
                      },
                      onLongPressCancel: () => () {
                        log("presssa");
                        setState(() {
                          press = false;
                        });
                      },
                      child: ReorderableDragStartListener(
                        enabled: press,
                        index: index,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                              leading: Checkbox(
                                  value: state.model[index].check,
                                  onChanged: ((value) {
                                    BlocProvider.of<ChartCubit>(context)
                                        .chartAdd();
                                    context
                                        .read<TodolistBloc>()
                                        .add(ChecktodoEvent(index, value!));
                                    print(state.model[index].toString());
                                  })),
                              subtitle: Text(
                                uselist[index].deadlineTime.format(context),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              trailing: PopupMenuButton(
                                initialValue: 2,
                                itemBuilder: (context) =>
                                    [PopupMenuItem(child: Text("fff"))],
                              ),
                              tileColor: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              title: Text(uselist[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: (uselist[index].finish!)
                                              ? Theme.of(context)
                                                  .unselectedWidgetColor
                                              : null,
                                          decoration: (uselist[index].finish!)
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none))),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      } else {
        return Text("loading");
      }
    });
  }

  ChoiceChip chipMake(String title, int index) {
    return ChoiceChip(
      selectedColor: Theme.of(context).primaryColorLight,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      label: Text(title),
      selected: widnum == index,
      onSelected: (value) {
        if (widnum != index) {
          setState(() {
            widnum = index;
          });
        }
      },
    );
  }

  List<Todolist> makeList(int num, List<Todolist> models) {
    if (num == 0) {
      return models;
    }
    if (num == 1) {
      return models
          .where(
              (element) => (element.finish != null) ? (element.finish!) : false)
          .toList();
    }
    if (num == 2) {
      return models
          .where(
              (element) => (element.finish != null) ? (!element.finish!) : true)
          .toList();
    } else {
      return [];
    }
  }
}
