import 'package:workout_timer/timer/timer_data_model.dart';

class TimerRepository {
  final TimerData timerData = const TimerData(
    preparing: 10,
    work: 20,
    timeOut: 15,
    cycles: 2,
    sets: 2,
    rest: 12,
    // add relax
  );
  final List<int> time = [10, 20, 15];
  final List<String> nameOfActivity = [
    'Підготовка',
    'Робота',
    'Відпочинок',
    'підготовка',
    'Заспокоїтися',
  ];
}
