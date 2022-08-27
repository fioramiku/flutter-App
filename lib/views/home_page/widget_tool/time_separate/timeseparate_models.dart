import 'package:equatable/equatable.dart';

class TimeseparateModels extends Equatable {
  final int sectiontime;
  final int breaktime;

  const TimeseparateModels({required this.sectiontime, this.breaktime = 0});

  @override

  List<Object?> get props => [sectiontime, breaktime];
}

