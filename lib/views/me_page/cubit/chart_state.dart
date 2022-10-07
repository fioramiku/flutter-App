part of 'chart_cubit.dart';

abstract class ChartState extends Equatable {
  const ChartState();

  @override
  List<Object> get props => [];
}

class ChartInitial extends ChartState {}

class ChartBuildState extends ChartState {
  final Map<String, double> data;
  const ChartBuildState(this.data);

  factory ChartBuildState.fromMap(Map<String, dynamic> map) {
    return ChartBuildState(Map<String, double>.from(map));
  }

  @override
  List<Object> get props => [data];
}
