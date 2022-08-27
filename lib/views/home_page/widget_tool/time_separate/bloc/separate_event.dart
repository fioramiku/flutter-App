part of 'separate_bloc.dart';

abstract class SeparateEvent extends Equatable {
  const SeparateEvent();

   @override

  List<Object?> get props => [];
}
class StartSeparate extends SeparateEvent{
  final TimeseparateModels models;
  const StartSeparate({required this.models});

}


class BuildSeperate extends SeparateEvent {
  final TimeseparateModels models;
  const BuildSeperate({required this.models});

  @override
  List<Object> get props => [models];
}


