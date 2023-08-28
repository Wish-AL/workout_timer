import 'dart:async';

class TimerElement {
  // TimerElement({required int time}) : timeCountdown = time;
  // //final int _time;


  Stream<int> timerDataStream(int time) {
    int timeCountdown = time;
    StreamController<int> controller = StreamController<int>();
    Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if(timeCountdown >= 0) {
          controller.add(timeCountdown--);
        } else if (timeCountdown == -1) {
          timer.cancel();
          controller.close();
        }
      },
    );

    return controller.stream;
  }
}
