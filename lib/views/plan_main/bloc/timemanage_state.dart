part of 'timemanage_bloc.dart';

class TimemanageState extends Equatable {
  final List<models_clock> mclock;
   bool checkstate; //rebuildroadmap
  final TimeOfDay? selelecttime;
  final bool checkclock;

  TimemanageState(
      {this.mclock=const <models_clock>[] ,
      this.checkstate = false,
      this.selelecttime,
      this.checkclock = false});

  TimemanageState copyWith({required List<models_clock> mclock}) {
    return TimemanageState(mclock: mclock, checkstate: true);
  }

  TimemanageState alreadycheck() {
    return TimemanageState(checkstate: true);
  }

  TimemanageState setTimepicker({required TimeOfDay selecttime}) {
    return TimemanageState(selelecttime: selelecttime);
  }

  List<models_clock> addlist({required models_clock z}) {
    List<models_clock> a = [...mclock];
    a.add(z);
    return a;
  }

  int con2min({required TimeOfDay timeOfDay}) {
    int time = timeOfDay.hour * 60 + timeOfDay.minute;
    return time;
  }

  List<models_clock> ordertime(
      {required List<models_clock> models, required TimeOfDay now}) {
    List<models_clock> alreadylist = [];
    List<models_clock> unfinishlist = [];

    final int timenow = con2min(timeOfDay: now);

    for (int i = 0; i < models.length; i++) {
      int checkedtime = con2min(timeOfDay: models[i].endtime);
      if (timenow > checkedtime) {
        alreadylist.add(models[i]);
      } else {
        unfinishlist.add(models[i]);
      }
    }
    alreadylist.sort(((a, b) => con2min(timeOfDay: a.endtime)
        .compareTo(con2min(timeOfDay: b.endtime))));
    unfinishlist.sort(((a, b) => con2min(timeOfDay: a.endtime)
        .compareTo(con2min(timeOfDay: b.endtime))));
    unfinishlist.addAll(alreadylist);

    return unfinishlist;
  }

  TimemanageState CompareTime(
      {required TimeOfDay timecompare, required TimeOfDay timenow}) {
    if (con2min(timeOfDay: timecompare) > con2min(timeOfDay: timenow)) {
      return TimemanageState(checkstate: true);
    } else {
      return TimemanageState(checkstate: this.checkstate);
    }
  }

  TimemanageState Changeroad({bool? b}) {
    return TimemanageState(checkstate: b?? true);
  }

  @override
  List<Object> get props => [mclock];
}

class TimemanageInitial extends TimemanageState {
  TimemanageInitial({List<models_clock>? mclock})
      : super();
}
