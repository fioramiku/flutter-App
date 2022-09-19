part of 'todolist_bloc.dart';

abstract class TodolistState extends Equatable {
  final List<Todolist> model;
  const TodolistState({required this.model});

  @override
  List<Object> get props => [model];
}


class BuildTodoState extends TodolistState{
  const BuildTodoState({required List<Todolist> model}) : super(model: model);

}
