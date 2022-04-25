import 'package:analog_clock/service/notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Alarm extends StatefulWidget {
  const Alarm({Key? key, required this.hour, required this.minute})
      : super(key: key);

  final int hour;
  final int minute;

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
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
    String formattedMinute = widget.minute < 10
        ? "0" + widget.minute.toString()
        : widget.minute.toString();
    return widget.hour.toString() + ":" + formattedMinute;
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Set the alarm here',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Switch(
          value: isAlarmOn,
          onChanged: (value) {
            setState(() {
              isAlarmOn = value;
              if (value) {
                //Set Alarm On
                NotificationApi.showNotification(
                  title: 'Alarm',
                  body: "Your alarm is ringing since ${convertToStringTime()}",
                  payload: scheduledDateTimeNow().toString(),
                  scheduleDate: scheduledDateTimeNow(),
                );
              } else {
                NotificationApi.cancel();
              }
              setSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          },
        ),
      ],
    );
  }
}
