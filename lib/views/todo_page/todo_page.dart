import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';
import 'package:abc/views/todo_page/inputdoto.dart';
import 'package:abc/views/todo_page/todo_history.dart';
import 'package:abc/views/todo_page/todo_view.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<TodolistBloc>().add(InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showBottomSheet(context: context, builder: (_) => InputTodowork()),
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: TodoView())
        ],
      ),
    );
  }
}
