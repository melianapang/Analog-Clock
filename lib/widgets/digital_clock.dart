import 'package:analog_clock/utils/colors.dart';
import 'package:analog_clock/widgets/hour_indicator.dart';
import 'package:analog_clock/widgets/minute_indicator.dart';
import 'package:analog_clock/widgets/second_indicator.dart';
import 'package:flutter/material.dart';
import 'clock_base_circle.dart';

//Class for creating digital clock
class DigitalClockWidget extends StatelessWidget {
  const DigitalClockWidget({
    Key? key,
    required this.time,
  }) : super(key: key);

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    final String hourFormat =
        time.hour < 10 ? ("0" + time.hour.toString()) : (time.hour.toString());

    final String minuteFormat = time.minute < 10
        ? ("0" + time.minute.toString())
        : (time.minute.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          hourFormat,
          style: const TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(':',
            style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold)),
        const SizedBox(
          width: 5,
        ),
        Text(
          minuteFormat,
          style: const TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
