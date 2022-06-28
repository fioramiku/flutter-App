part of 'timemanage_bloc.dart';

abstract class TimemanageEvent extends Equatable {
  const TimemanageEvent();

  @override
  List<Object> get props => [];
}

class Changeclock extends TimemanageEvent {
  final models_clock newmodels;
  Changeclock({required this.newmodels});
}

class ChangeTimepicker extends TimemanageEvent {
  final TimeOfDay selecttime;
  ChangeTimepicker({required this.selecttime});
}
