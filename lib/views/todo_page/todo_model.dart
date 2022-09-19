import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Todolist extends Equatable {
  final TimeOfDay deadlineTime;
  final DateTime deadlineDate;
  final String title;

  const Todolist({required this.deadlineTime, required this.title,required this.deadlineDate});

  @override
  List<Object?> get props => [deadlineTime,deadlineDate, title];
}
