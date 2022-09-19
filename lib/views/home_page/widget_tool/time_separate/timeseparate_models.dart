import 'package:equatable/equatable.dart';

class TimeseparateModels extends Equatable {
  final Duration? sectiontime;
  final Duration? breaktime;
  final int? looptime;
  final double? percent;

  const TimeseparateModels({this.sectiontime, this.breaktime, this.looptime,this.percent});

  @override
  List<Object?> get props => [sectiontime, breaktime, looptime];
}
