import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../database/Database_api.dart';
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
  TodolistBloc() : super(TodolistState(model: [])) {
    on<AddtodoEvent>(_addTodo);
    on<DeletetodoEvent>(_deleteTodo);
    on<SwapTodoEvent>(_swapTodo);
    on<InitialEvent>(_initialTodo);
    on<ChecktodoEvent>(_checkTodo);
    print("ff");
  }
  void _initialTodo(InitialEvent event, Emitter<TodolistState> emit) async {
    var db = Database_api();
    var models = await db.dbload(1);
    if (models != null) emit(models);
    print("dd" + models.toString());
  }

  void _addTodo(AddtodoEvent event, Emitter<TodolistState> emit) async {
    if (state is BuildTodoState) {
      emit(BuildTodoState(model: List.from(state.model)..add(event.model)));
    }
    update();
  }

  void _deleteTodo(DeletetodoEvent event, Emitter<TodolistState> emit) {
    if (state is BuildTodoState) {
      emit(BuildTodoState(
          model: List<Todolist>.from(state.model)..remove(event.model)));
    }
    update();
  }

  void _swapTodo(SwapTodoEvent event, Emitter<TodolistState> emit) {
    if (state is BuildTodoState) {
      var item = List<Todolist>.from(state.model).removeAt(event.oldindex);

      emit(BuildTodoState(
          model: List<Todolist>.from(state.model)
            ..removeAt(event.oldindex)
            ..insert(event.newindex, item)));
    }
    update();
  }

  void _checkTodo(ChecktodoEvent event, Emitter<TodolistState> emit) {
    if (state is BuildTodoState) {
      log(event.check.toString());
      var list = List<Todolist>.from(state.model);
      list[event.index]=Todolist.copyTodo(todo:list[event.index],finish: event.check );

            
     
      emit(BuildTodoState(
          model:list ));
      
    }
  }

  void update() async {
    final state = this.state;
    if (state is BuildTodoState) {
      var db = Database_api();
      await db.dbAdd(BuildTodoState(model: state.model), 1);
      print("update" + state.model.length.toString() + state.toString());

      var models = await db.dbload(1);

      print("open" + models.toString());
    }

  }
}
