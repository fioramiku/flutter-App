import 'dart:math';

import 'package:abc/database/Database_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  ChartCubit() : super(ChartInitial());

  void chartAdd() async {
    final DateTime now = DateTime.now();
    final state = this.state;
    if (state is ChartBuildState) {
      var map = Map<String, double>.from(state.data);
      map[now.weekday.toString()] = map[now] ?? 0 + 1;
      emit(ChartBuildState(map));

      await Database_api().dbAdd(state, 3);
    }
  }

  void chartInitialEvent() async {
    var chart = await Database_api().dbload(3);
    if (chart != null) emit(chart);
  }
}
