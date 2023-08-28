import 'dart:async';



import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/timer/timer_element.dart';

import '../timer_repository.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit({required TimerRepository timerRepository})
      : _repository = timerRepository,
        super(const TimerState());

  final TimerRepository _repository;

  late TimerElement preparingTime =
      TimerElement(); // = TimerElement(time: _repository.timerData.preparing);
  bool pauseButtonPressedStatus = false;
  late StreamSubscription<int> preparingTimeStream;

  void getPreparingTime() {
    int time = _repository.timerData.preparing;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        time--;
        emit(
          state.copyWith(
            timerCountdown: time,
          ),
        );
        if (time == 0) {
          timer.cancel();
        }
      },
    );
  }

  Future<void> runTimer() async {
    int sets = _repository.timerData.sets;
    emit(
      state.copyWith(
        activity: 0,
      ),
    );

    while (sets > 0) {
      int cycles = _repository.timerData.cycles;
      while (cycles > 0) {
        for (int i = 0; i <= 2; i++) {
          int count = _repository.time[i];
          emit(
            state.copyWith(
              activity: await getTime(count, i + 1),
            ),
          );
        }
        cycles--;
      }
      sets--;
      emit(
        state.copyWith(
          activity: await getTime(_repository.timerData.rest, 4),
        ),
      );
    }
  }

  void onPressPauseButton() {
    if (preparingTimeStream != null) {
      (!pauseButtonPressedStatus)
          ? preparingTimeStream.pause()
          : preparingTimeStream.resume();
      pauseButtonPressedStatus = !pauseButtonPressedStatus;
    }
  }

  Future<int> getTime(int time, int activity) async {
    int countDown = time;
    //StreamSubscription<int> streamSubscription
    preparingTimeStream = preparingTime.timerDataStream(time).listen(
      (event) {
        emit(
          state.copyWith(
            timerCountdown: event,
          ),
        );
        countDown = event;
      },
    );

    if (countDown == 0) {
      preparingTimeStream.cancel();
    }
    return preparingTimeStream.asFuture(activity);
  }
}
