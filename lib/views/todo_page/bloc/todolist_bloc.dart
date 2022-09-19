import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../todo_model.dart';

part 'todolist_event.dart';
part 'todolist_state.dart';
/*
extension SwappableList<E> on List<E> {
  void swap(int index1, int index2) {
    RangeError.checkValidIndex(index1, this, 'index1');
    RangeError.checkValidIndex(index2, this, 'index2');
    var tmp = this[index1];
    this[index1] = this[index2];
    this[index2] = tmp;
  }
}
*/
class TodolistBloc extends Bloc<TodolistEvent, TodolistState> {
  TodolistBloc()
      : super(BuildTodoState(model: [
          Todolist(
              deadlineTime: TimeOfDay(hour: 3, minute: 3),
              title: "hello",
              deadlineDate: DateTime.now())
        ])) {
    on<AddtodoEvent>(_addTodo);
    on<DeletetodoEvent>(_deleteTodo);
    on<SwapTodoEvent>(_swapTodo);
  }

  void _addTodo(AddtodoEvent event, Emitter<TodolistState> emit) {
    if (state is BuildTodoState) {
      emit(BuildTodoState(model: List.from(state.model)..add(event.model)));
    }
  }

  void _deleteTodo(DeletetodoEvent event, Emitter<TodolistState> emit) {
    if (state is BuildTodoState) {
      emit(BuildTodoState(
          model: List<Todolist>.from(state.model)..remove(event.model)));
    }
  }

  void _swapTodo(SwapTodoEvent event, Emitter<TodolistState> emit) {
    if (state is BuildTodoState) {
      var item = List<Todolist>.from(state.model).removeAt(event.oldindex);

      emit(BuildTodoState(
          model: List<Todolist>.from(state.model)..removeAt(event.oldindex)
            ..insert(event.newindex, item)));
    }
  }
}
