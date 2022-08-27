part of 'separate_bloc.dart';

abstract class SeparateState extends Equatable {
  final TimeseparateModels models;

  const SeparateState({required this.models});
  @override
  List<Object> get props => [models];
}

class SeparateInitialState extends SeparateState {
  const SeparateInitialState({required TimeseparateModels models})
      : super(models: models);
}

class UsingSeparateState extends SeparateState {
  const UsingSeparateState({required TimeseparateModels models})
      : super(models: models);
}

