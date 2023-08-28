import 'package:equatable/equatable.dart';

class TimerData extends Equatable {
  final int preparing;
  final int work;
  final int timeOut;
  final int cycles;
  final int sets;
  final int rest;

  const TimerData({
    required this.preparing,
    required this.work,
    required this.timeOut,
    required this.cycles,
    required this.sets,
    required this.rest,
  });

  @override
  List<Object?> get props => [
        preparing,
        work,
        timeOut,
        cycles,
        sets,
        rest,
      ];
}
