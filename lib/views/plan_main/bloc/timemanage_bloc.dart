import 'dart:collection';
import 'dart:developer';

import 'package:abc/database/Database_api.dart';
import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

part 'timemanage_event.dart';
part 'timemanage_state.dart';

class TimemanageBloc extends Bloc<TimemanageEvent, TimemanageState> {
  TimemanageBloc() : super(InitialClockState()) {
    on<Addclock>((_updateMap));
    on<Deleteclock>((_deleteItem));
    on<Changeday>((_changeDay));
    on<Changeclock>((_changeData));
    on<InitialClockEvent>(_initialclockevent);
  }

  void _initialclockevent(
      InitialClockEvent event, Emitter<TimemanageState> emit) async {
    var database = await Database_api().dbload(2);
    if(database!=null)emit(database);
  }

  void _updateMap(Addclock event, Emitter<TimemanageState> emit) {
    final state = this.state;
    if (state is BuildClockState) {
      final _linkmap = LinkedHashMap<DateTime, List<models_clock>?>(
          equals: (DateTime a, DateTime b) => isSameDay(a, b),
          hashCode: (e) => 1)
        ..addAll(state.mclock!);

      int con2min({required TimeOfDay timeOfDay}) {
        int time = timeOfDay.hour * 60 + timeOfDay.minute;
        return time;
      }

      Map<int, List<models_clock>> ordList(
          {required List<models_clock>? models}) {
        final int now = con2min(timeOfDay: TimeOfDay.now());

        List<models_clock> finList = [];
        List<models_clock> unfinList = [];
        for (models_clock i in models!) {
          final int dif1 = con2min(timeOfDay: i.starttime) - now;
          final int dif2 = con2min(timeOfDay: i.endtime) - now;
          if (dif1 > 0) {
            if (dif2 > 0) {
              i.stateIndex = 1;
              unfinList.add(i);
            } else {
              i.stateIndex = 0;
              finList.add(i);
            }
          } else {
            if (dif2 > 0) {
              i.stateIndex = 0;
              finList.add(i);
            } else {
              i.stateIndex = 1;
              unfinList.add(i);
            }
          }
        }
        int dataset(
          models_clock models,
        ) {
          int a = con2min(timeOfDay: models.starttime);
          int check = a - now;
          if (a < now) {
            return 3600 - (check).abs();
          } else {
            return check;
          }
        }

        unfinList.sort(((a, b) => dataset(a).compareTo(dataset(b))));
        finList.sort(((a, b) => dataset(a).compareTo(dataset(b))));
        return {
          0: unfinList,
          1: finList,
          2: [...finList, ...unfinList]
        };
      }

      LinkedHashMap<DateTime, List<models_clock>?> addMap(
          {models_clock? z, required DateTime selectday}) {
        if (_linkmap[selectday] != null) {
          if (z != null) {
            _linkmap[selectday]!.add(z);
          }
        } else {
          _linkmap[selectday] = [z!];
        }

        _linkmap[selectday] = ordList(models: _linkmap[selectday])[2];
        log(_linkmap.toString());
        return _linkmap;
      }

      log((state.mclock == _linkmap).toString());

      emit(state.copyWith(
          mclock: addMap(z: event.newmodels, selectday: event.day),
          selectday: state.selectday));

      update();
    }
  }

  void _deleteItem(Deleteclock event, Emitter<TimemanageState> emit) {
    final state = this.state;
    if (state is BuildClockState) {
      final _linkmap = LinkedHashMap<DateTime, List<models_clock>?>(
          equals: (DateTime a, DateTime b) => isSameDay(a, b),
          hashCode: (e) => 1)
        ..addAll(state.mclock!);
      _linkmap[state.selectday]!.remove(event.models);

      log((state.mclock == _linkmap).toString());

      emit(state.copyWith(selectday: state.selectday, mclock: _linkmap));
      update();
    }
  }

  void _changeDay(Changeday event, Emitter<TimemanageState> emit) {
    final state = this.state;
    if (state is BuildClockState) {
      emit(state.copyWith(selectday: event.focusday));
      update();
    }
  }

  void _changeData(Changeclock event, Emitter<TimemanageState> emit) {
    final state = this.state;
    if (state is BuildClockState) {
      final _linkmap = LinkedHashMap<DateTime, List<models_clock>?>(
          equals: (DateTime a, DateTime b) => isSameDay(a, b),
          hashCode: (e) => 1)
        ..addAll(state.mclock!);
      _linkmap[event.day]![_linkmap[event.day]!.indexOf(event.oldmodel)] =
          event.changemodel;
      emit(state.copyWith(selectday: event.day, mclock: _linkmap));
      update();
    }
  }

  void update() async {
    var db = Database_api();
    await db.dbAdd(state, 2);
  }
}
