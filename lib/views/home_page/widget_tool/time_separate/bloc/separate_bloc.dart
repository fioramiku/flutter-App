import 'dart:async';

import 'package:abc/views/home_page/widget_tool/time_separate/ticker.dart';
import 'package:abc/views/home_page/widget_tool/time_separate/timeseparate_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'separate_event.dart';
part 'separate_state.dart';

class SeparateBloc extends Bloc<SeparateEvent, SeparateState> {
  Ticker _ticker;
  static TimeseparateModels _models =
      TimeseparateModels(sectiontime: 30, breaktime: 5);
  StreamSubscription<int>? _tickerSubscription;
  SeparateBloc({required Ticker ticker})
      : _ticker = ticker,
        super( SeparateInitialState(
            models: _models)) {
    on<StartSeparate>(_startSeparate);
    on<BuildSeperate>(_buildSeparate);
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
          models: TimeseparateModels(sectiontime: 30, breaktime: 5)));
      _tickerSubscription = _ticker
          .tick(ticks: event.models.sectiontime)
          .listen((event) => add(
              BuildSeperate(models: TimeseparateModels(sectiontime: event))));
    }
  }

  void _buildSeparate(BuildSeperate event, Emitter<SeparateState> emit) {
    if (state is UsingSeparateState) {
      emit(event.models.sectiontime > 0
          ? UsingSeparateState(
              models: TimeseparateModels(sectiontime: event.models.sectiontime))
          : SeparateInitialState(models: _models));
    }
  }
}
