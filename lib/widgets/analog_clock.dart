import 'package:analog_clock/utils/colors.dart';
import 'package:analog_clock/widgets/hour_indicator.dart';
import 'package:analog_clock/widgets/minute_indicator.dart';
import 'package:analog_clock/widgets/second_indicator.dart';
import 'package:flutter/material.dart';
import 'clock_base_circle.dart';

class AnalogClockWidget extends StatelessWidget {
  const AnalogClockWidget({
    Key? key,
    required this.hourAngle,
    required this.minAngle,
    required this.secAngle,
  }) : super(key: key);

  final double hourAngle;
  final double minAngle;
  final double secAngle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClockBaseCircle(),
        HourIndicator(
          angle: hourAngle,
        ),
        MinuteIndicator(
          angle: minAngle,
        ),
        SecondIndicator(
          angle: secAngle,
        ),
        //Center Dot
        Container(
          height: 6.0,
          width: 6.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: grey3VectoraColor,
          ),
        ),
      ],
    );
  }
}
