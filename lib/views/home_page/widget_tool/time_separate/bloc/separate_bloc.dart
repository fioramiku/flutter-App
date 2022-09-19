import 'dart:async';
import 'dart:isolate';

import 'package:abc/views/home_page/widget_tool/time_separate/ticker.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/timeseparate_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'separate_event.dart';
part 'separate_state.dart';

class SeparateBloc extends Bloc<SeparateEvent, SeparateState> {
  final Ticker _ticker;

  static final TimeseparateModels _models = TimeseparateModels(
      sectiontime: Duration(seconds: 30),
      breaktime: Duration(seconds: 20),
      looptime: 3);
  StreamSubscription<int>? _tickerSubscription;
  StreamSubscription<int>? _cooltickSubscription;
  SeparateBloc({required Ticker ticker})
      : _ticker = ticker,
        super(SeparateInitialState(
            models: _models, loopnum: 3, defaultmodels: _models)) {
    on<StartSeparate>(_startSeparate);
    on<BuildSeperate>(_buildSeparate);
    on<CooldownEvent>(_cooldownSeparate);
    on<InitialSeparate>(_initialSeparate);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  

  void _startSeparate(StartSeparate event, Emitter<SeparateState> emit) {
    if (state is SeparateInitialState) {
      _tickerSubscription?.cancel();

      emit(UsingSeparateState(
          models: state.models, loopnum: state.loopnum, defaultmodels: state.models));
      _tickerSubscription = _ticker
          .tick(ticks: event.models.sectiontime!.inSeconds)
          .listen((event) => add(BuildSeperate(
              models:
                  TimeseparateModels(sectiontime: Duration(seconds: event)))));
    }
  }

  void _buildSeparate(BuildSeperate event, Emitter<SeparateState> emit) {
    if (state is UsingSeparateState) {
      if (event.models.sectiontime!.inSeconds > 0) {
        emit(UsingSeparateState(
            defaultmodels: state.defaultmodels,
            models: TimeseparateModels(
              sectiontime: event.models.sectiontime,
            ),
            loopnum: state.loopnum));
      } else {
        //to cooldown

        _tickerSubscription?.cancel();
        emit(CooldownState(
            models: state.defaultmodels, loopnum: state.loopnum, defaultmodels:state.defaultmodels));

        _cooltickSubscription = _ticker
            .tick(ticks: state.defaultmodels.breaktime!.inSeconds)
            .listen((event) => add(CooldownEvent(
                models:
                    TimeseparateModels(breaktime: Duration(seconds: event)))));
      }
    }
  }

  void _cooldownSeparate(CooldownEvent event, Emitter<SeparateState> emit) {
    if (state is CooldownState) {
      if (event.models.breaktime!.inSeconds > 0) {
        emit(CooldownState(
            defaultmodels: state.defaultmodels,
            models: TimeseparateModels(breaktime: event.models.breaktime),
            loopnum: state.loopnum));
      } else {
        _cooltickSubscription?.cancel();
        emit(UsingSeparateState(
            defaultmodels:state.defaultmodels,
            models: state.defaultmodels,
            loopnum: state.loopnum - 1));
        _tickerSubscription = _ticker
            .tick(ticks: state.defaultmodels.sectiontime!.inSeconds)
            .listen((event) => add(BuildSeperate(
                models: TimeseparateModels(
                    sectiontime: Duration(seconds: event)))));
      }
    }
  }

  void _initialSeparate(InitialSeparate event, Emitter<SeparateState> emit) {
    emit(SeparateInitialState(
        models: event.models, loopnum: 3, defaultmodels: event.models));
  }
}
