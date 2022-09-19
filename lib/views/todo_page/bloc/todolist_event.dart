part of 'todolist_bloc.dart';

abstract class TodolistEvent extends Equatable {
  const TodolistEvent();

  @override
  List<Object> get props => [];
}

class AddtodoEvent extends TodolistEvent {
  final Todolist model;
  const AddtodoEvent({required this.model});

  @override
  List<Object> get props => [model];
}

class DeletetodoEvent extends TodolistEvent {
  final Todolist model;
  const DeletetodoEvent({required this.model});

  @override
  List<Object> get props => [model];
}

class SwapTodoEvent extends TodolistEvent {
  final int oldindex;
  final int newindex;
  const SwapTodoEvent({required this.oldindex, required this.newindex});
}
