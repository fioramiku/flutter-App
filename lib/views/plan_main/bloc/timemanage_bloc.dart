import 'dart:developer';

import 'package:abc/views/plan_main/models/time_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'timemanage_event.dart';
part 'timemanage_state.dart';

class TimemanageBloc extends Bloc<TimemanageEvent, TimemanageState> {
  TimemanageBloc() : super(TimemanageInitial()) {
    on<Changeclock>((event, emit) {
      for (models_clock a in state.mclock!) {
        log("name: " + a.title);
      }

      emit(state.copyWith(mclock: state.addlist(z: event.newmodels)));
    });

    on<ChangeTimepicker>((event, emit) => emit(state.setTimepicker(selecttime: event.selecttime)));
    on<Changeroad>(((event, emit) => emit(state.Changeroad(b: event.b))));
  }
}
