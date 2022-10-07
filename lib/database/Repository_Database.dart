import 'package:abc/views/me_page/bloc/profile_bloc.dart';
import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';

class Repository_Database {
  final ProfileState? profileState;
  final TodolistState? todolistState;
  Repository_Database({required this.profileState,required this.todolistState});
}
