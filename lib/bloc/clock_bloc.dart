import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';

//Once run using this BLoC, the clock doesn't work properly, such as it doesn't stream per second.
class BlocClock extends ChangeNotifier {
  double secondsAngle = 0;
  double minutesAngle = 0;
  double hoursAngle = 0;
  late Timer timer;

  BlocClock() {
    restoreTimer();
  }

  //Reset Timer
  void restoreTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      secondsAngle = updateSecondsAngle(now.second);
      minutesAngle = updateMinuteAngle(now.minute);
      hoursAngle = updateHourAngle(now.hour);
    });
  }

  //Convert from minute to angle degrees
  double updateSecondsAngle(int seconds) {
    return (pi / 30) * seconds;
  }

  //Convert from minute to angle degrees
  double updateMinuteAngle(int minute) {
    return (pi / 30) * minute;
  }

  //Convert from hour to angle degrees
  double updateHourAngle(int hour) {
    return (pi / 6 * hour) + (pi / 45 * minutesAngle);
  }

  //Rounding number base 10 example 76 become 80
  double roundNearestTen(double number) {
    double a = (number / 10) * 10;
    double b = a + 10;
    return (number - a > b - number) ? b : a;
  }

  //Convert from degree to radians.
  double degreeToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
