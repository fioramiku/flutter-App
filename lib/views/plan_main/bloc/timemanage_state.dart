part of 'timemanage_bloc.dart';

abstract class TimemanageState extends Equatable {
  const TimemanageState();

  @override
  List<Object> get props => [];

  
}

class BuildClockState extends TimemanageState{
  final DateTime selectday;
  final LinkedHashMap<DateTime, List<models_clock>?>? mclock;
  
  const BuildClockState({required this.selectday, this.mclock});

  Map<String, dynamic> toMap() {
    return {
      'selectday': selectday.toString(),
      'mclock': Map.from(mclock!.map((key, value) => MapEntry(
          key.toString(),
          Map.fromIterable(value!,
              key: (element) => value.indexOf(element).toString(),
              value: (element) =>
                  (element is models_clock) ? element.toMap() : null))))
    };
  }

  factory BuildClockState.formMap(Map<String, dynamic> map) {
    List<models_clock>? l2m(Map map) {
      var list = <models_clock>[];
      map.forEach((key, value) {
          list.add(models_clock.formMap(Map.from(value)));
      });
      return list;
    }


    return BuildClockState(
        selectday: DateTime.parse((map['selectday'] !=null)?map['selectday']:DateTime.now().toString()),
        mclock:(map['mclock']!=null)? LinkedHashMap.from(Map.from(map['mclock']).map((key, value) =>
            MapEntry(DateTime.parse(key),l2m(value as Map)
                ))): LinkedHashMap() );
  }

  int con2min({required TimeOfDay timeOfDay}) {
    int time = timeOfDay.hour * 60 + timeOfDay.minute;
    return time;
  }

  BuildClockState copyWith(
      {LinkedHashMap<DateTime, List<models_clock>?>? mclock,
      required DateTime selectday}) {
    return BuildClockState(mclock: mclock ?? this.mclock, selectday: selectday);
  }

  List<models_clock> ordertime(
      {required List<models_clock> models, required TimeOfDay now}) {
    List<models_clock> alreadylist = [];
    List<models_clock> unfinishlist = [];

    final int timenow = con2min(timeOfDay: now);
    //+ mean pass - mean not pass

    for (int i = 0; i < models.length; i++) {
      int checkedtime = con2min(timeOfDay: models[i].starttime);
      int checkedtime2 = con2min(timeOfDay: models[i].endtime);
      int different1 = timenow - checkedtime;
      int different2 = timenow - checkedtime2;
      if ((different1 > 0 && different2 < 0) ||
          (different1 > 0 && different2 > 0) ||
          (different1 < 0 && different2 < 0) ||
          (different1 < 0 && different2 > 0)) {
        alreadylist.add(models[i]);
        log("time${models[i].starttime}");
      } else {
        unfinishlist.add(models[i]);
      }
    }
    //convert models time to sec
    int dataset(
      models_clock models,
    ) {
      int a = con2min(timeOfDay: models.starttime);
      int check = a - timenow;
      if (a < timenow) {
        return 3600 - (check).abs();
      } else {
        return check;
      }
    }

    alreadylist.sort(((a, b) => dataset(a).compareTo(dataset(b))));
    unfinishlist.sort(((a, b) => dataset(a).compareTo(dataset(b))));

    return [...unfinishlist, ...alreadylist];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildClockState &&
          runtimeType == other.runtimeType &&
          mclock == other.mclock &&
          selectday == other.selectday;

  @override
  int get hashCode => mclock.hashCode ^ selectday.hashCode;
}

class InitialClockState extends TimemanageState{
  

}

  





/*
class TimeLoaded extends TimemanageState {
  final DateTime selectday;
  final LinkedHashMap<DateTime, List<models_clock>?> mclock;
  const TimeLoaded(
      {required this.selectday,
      required this.mclock});

  int con2min({required TimeOfDay timeOfDay}) {
    int time = timeOfDay.hour * 60 + timeOfDay.minute;
    return time;
  }

  TimeLoaded copyWith(
      {required LinkedHashMap<DateTime, List<models_clock>?> mclock,required DateTime selectday}) {
    return TimeLoaded(mclock:mclock, selectday: selectday);
  }

  List<models_clock> ordertime(
      {required List<models_clock> models, required TimeOfDay now}) {
    List<models_clock> alreadylist = [];
    List<models_clock> unfinishlist = [];

    final int timenow = con2min(timeOfDay: now);
    //+ mean pass - mean not pass

    for (int i = 0; i < models.length; i++) {
      int checkedtime = con2min(timeOfDay: models[i].starttime);
      int checkedtime2 = con2min(timeOfDay: models[i].endtime);
      int different1 = timenow - checkedtime;
      int different2 = timenow - checkedtime2;
      if ((different1 > 0 && different2 < 0) ||
          (different1 > 0 && different2 > 0) ||
          (different1 < 0 && different2 < 0) ||
          (different1 < 0 && different2 > 0)) {
        alreadylist.add(models[i]);
        log("time${models[i].starttime}");
      } else {
        unfinishlist.add(models[i]);
      }
    }
    //convert models time to sec
    int dataset(
      models_clock models,
    ) {
      int a = con2min(timeOfDay: models.starttime);
      int check = a - timenow;
      if (a < timenow) {
        return 3600 - (check).abs();
      } else {
        return check;
      }
    }

    alreadylist.sort(((a, b) => dataset(a).compareTo(dataset(b))));
    unfinishlist.sort(((a, b) => dataset(a).compareTo(dataset(b))));

    return [...unfinishlist,...alreadylist];
  }

  @override
  List<Object> get props => [mclock,selectday];
}


  final LinkedHashMap<DateTime, List<models_clock>?>? mclock;
  final bool checkstate; //rebuildroadmap
  final TimeOfDay? selelecttime;
  final bool checkclock;
  final DateTime? selectday;
  
  TimemanageState(
      {this.mclock,
      this.checkstate = false,
      this.selelecttime,
      this.checkclock = false,
      this.selectday});

  TimemanageState copyWith(
      {required LinkedHashMap<DateTime, List<models_clock>?> mclock}) {
    return TimemanageState(mclock: mclock, checkstate: true);
  }

  TimemanageState alreadycheck() {
    return TimemanageState(checkstate: true);
  }

  TimemanageState setTimepicker({required TimeOfDay selecttime}) {
    return TimemanageState(selelecttime: selelecttime);
  }

  ///////-----
 
  int con2min({required TimeOfDay timeOfDay}) {
    int time = timeOfDay.hour * 60 + timeOfDay.minute;
    return time;
  }

  List<models_clock> ordertime(
      {required List<models_clock> models, required TimeOfDay now}) {
    List<models_clock> alreadylist = [];
    List<models_clock> unfinishlist = [];

    final int timenow = con2min(timeOfDay: now);
    //+ mean pass - mean not pass

    for (int i = 0; i < models.length; i++) {
      int checkedtime = con2min(timeOfDay: models[i].starttime);
      int checkedtime2 = con2min(timeOfDay: models[i].endtime);
      int different1 = timenow - checkedtime;
      int different2 = timenow - checkedtime2;
      if ((different1 > 0 && different2 < 0) ||
          (different1 > 0 && different2 > 0) ||
          (different1 < 0 && different2 < 0) ||
          (different1 < 0 && different2 > 0)) {
        alreadylist.add(models[i]);
        log("time${models[i].starttime}");
      } else {
        unfinishlist.add(models[i]);
      }
    }
    //convert models time to sec
    int dataset(
      models_clock models,
    ) {
      int a = con2min(timeOfDay: models.starttime);
      int check = a - timenow;
      if (a < timenow) {
        return 3600 - (check).abs();
      } else {
        return check;
      }
    }

    alreadylist.sort(((a, b) => dataset(a).compareTo(dataset(b))));
    unfinishlist.sort(((a, b) => dataset(a).compareTo(dataset(b))));

    return unfinishlist;
  }

  TimemanageState compareTime(
      {required TimeOfDay timecompare, required TimeOfDay timenow}) {
    if (con2min(timeOfDay: timecompare) > con2min(timeOfDay: timenow)) {
      return TimemanageState(checkstate: true);
    } else {
      return TimemanageState(checkstate: this.checkstate);
    }
  }

  TimemanageState changeRoad({required bool b}) {
    return TimemanageState(checkstate: b, mclock: mclock);
  }

  //con2Likedhastmap
  LinkedHashMap<DateTime, List<models_clock>?> getmap() {
    LinkedHashMap<DateTime, List<models_clock>?> linkmap = LinkedHashMap(
        equals: (DateTime a, DateTime b) => isSameDay(a, b), hashCode: (e) => 1)
      ..addAll(mclock!);
    return linkmap;
  }
*/