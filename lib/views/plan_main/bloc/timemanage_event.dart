part of 'timemanage_bloc.dart';

abstract class TimemanageEvent extends Equatable {
  const TimemanageEvent();

  @override
  List<Object> get props => [];
}

class Addclock extends TimemanageEvent {
  final models_clock? newmodels;
  final DateTime day;
  const Addclock({this.newmodels, required this.day});
}

class Deleteclock extends TimemanageEvent {
  final models_clock models;
  final DateTime daySelect;
  const Deleteclock({required this.models, required this.daySelect});
}

class Changeday extends TimemanageEvent {
  final DateTime focusday;
  const Changeday({required this.focusday});
}

class Changeclock extends TimemanageEvent {
  final models_clock oldmodel;
  final models_clock changemodel;
  final DateTime day;
  const Changeclock({required this.oldmodel,required this.changemodel, required this.day});
}
class InitialClockEvent extends TimemanageEvent{
}
