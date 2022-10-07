part of 'todolist_bloc.dart';

class TodolistState extends Equatable {
  final List<Todolist> model;

  const TodolistState({required this.model,});

  @override
  List<Object> get props => [model];
}

class BuildTodoState extends TodolistState {
  const BuildTodoState({required List<Todolist> model}) : super(model: model);



 

  Map<String, dynamic> toMap() => Map.fromIterable(
        model,
        key: (e) => model.indexOf(e).toString(),
        value: (element) => (element is Todolist) ? element.toMap() : null,
      );

  factory BuildTodoState.fromMap(Map<String, dynamic> map) {
    var list = <Todolist>[];
    map.forEach((key, value) {
      print("$key$value");

      return list.add(Todolist.fromMap(value));
    });

    return BuildTodoState(model: list);
  }

  @override
  List<Object> get props => [model];
}
