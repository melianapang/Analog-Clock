import 'package:analog_clock/utils/colors.dart';
import 'package:flutter/material.dart';

//Class for Minute indicator rotation
class MinuteIndicator extends StatelessWidget {
  const MinuteIndicator({
    Key? key,
    required this.angle,
  }) : super(key: key);

  final double angle;

  @override
  Widget build(BuildContext context) {
    final vHeight = MediaQuery.of(context).size.height;

    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: const Offset(0, 40),
          child: Container(
            height: vHeight * 0.16,
            width: 3.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                6.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
