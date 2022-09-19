part of 'separate_bloc.dart';

abstract class SeparateState extends Equatable {
  final TimeseparateModels models;
  final int loopnum;
  final TimeseparateModels defaultmodels;

  const SeparateState({required this.models, required this.loopnum,required this.defaultmodels});
  @override
  List<Object> get props => [models, loopnum];
}

class SeparateInitialState extends SeparateState {
  SeparateInitialState({required TimeseparateModels models, required int loopnum, required TimeseparateModels defaultmodels}) : super(models: models, loopnum: loopnum, defaultmodels: defaultmodels);
 
}

class UsingSeparateState extends SeparateInitialState {
  UsingSeparateState({required TimeseparateModels models, required int loopnum, required TimeseparateModels defaultmodels}) : super(models: models, loopnum: loopnum, defaultmodels: defaultmodels);
  
}

class CooldownState extends SeparateInitialState {
  CooldownState({required TimeseparateModels models, required int loopnum, required TimeseparateModels defaultmodels}) : super(models: models, loopnum: loopnum, defaultmodels: defaultmodels);
  
}
