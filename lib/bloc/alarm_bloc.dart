import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Once run using this BLoC, the clock doesn't work properly, such as it doesn't stream per second.
class BlocAlarm extends ChangeNotifier {
  final int hour;
  final int minute;

  BlocAlarm(
    this.hour,
    this.minute,
  ) {}

  late SnackBar snackBar;
  bool isAlarmOn = false;

  DateTime scheduledDateTimeNow() {
    final now = DateTime.now();
    final scheduleTimeHHmm = DateFormat('HH:mm').parse(convertToStringTime());
    var day = now.day;

    //if the user sets an alarm time that is smaller than the current time, the alarm will be ringing at the set hour and minute at the next day
    if (int.parse(now.hour.toString()) >
            int.parse(scheduleTimeHHmm.hour.toString()) ||
        int.parse(now.hour.toString()) ==
                int.parse(scheduleTimeHHmm.hour.toString()) &&
            int.parse(now.minute.toString()) >=
                int.parse(scheduleTimeHHmm.minute.toString())) {
      day = now.day + 1;
    }

    return DateTime(now.year, now.month, day, scheduleTimeHHmm.hour,
        scheduleTimeHHmm.minute);
  }

  String convertToStringTime() {
    String formattedMinute =
        minute < 10 ? "0" + minute.toString() : minute.toString();
    return hour.toString() + ":" + formattedMinute;
  }

  void setSnackBar() {
    snackBar = SnackBar(
      content: Text(
        isAlarmOn
            ? 'Alarm is On! You will be notified on the next ' +
                convertToStringTime()
            : 'Alarm is Off',
      ),
    );
  }
}
