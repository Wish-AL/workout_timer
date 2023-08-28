part of 'timer_cubit.dart';

class TimerState extends Equatable {
  const TimerState({
    this.timerCountdown = 0,
    this.activity = 0,
  });

  final int timerCountdown;
  final int activity;

  TimerState copyWith({
    int? timerCountdown,
    int? activity,
  }) {
    return TimerState(
      timerCountdown: timerCountdown ?? this.timerCountdown,
      activity: activity ?? this.activity,
    );
  }

  @override
  List<Object?> get props => [timerCountdown, activity];
}
