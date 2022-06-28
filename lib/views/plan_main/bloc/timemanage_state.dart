part of 'timemanage_bloc.dart';

class TimemanageState extends Equatable {
  final List<models_clock> mclock;
  final bool checkstate;
  final TimeOfDay? selelecttime;
  final bool checkclock;

  TimemanageState(
      {this.mclock = const <models_clock>[],
      this.checkstate = false,
      this.selelecttime,
      this.checkclock = false});

  TimemanageState copyWith({required List<models_clock> mclock}) {
    return TimemanageState(mclock: mclock, checkstate: true);
  }

  TimemanageState alreadycheck() {
    return TimemanageState(checkstate: false);
  }

  TimemanageState setTimepicker({required TimeOfDay selecttime}) {
    return TimemanageState(selelecttime: selelecttime);
  }

  List<models_clock> addlist({required models_clock z}) {
    List<models_clock> a = [...mclock];
    a.add(z);
    return a;
  }

  @override
  List<Object> get props => [mclock];
}

class TimemanageInitial extends TimemanageState {
  TimemanageInitial({List<models_clock>? mclock})
      : super(mclock: mclock = const <models_clock>[]);
}
