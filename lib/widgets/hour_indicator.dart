import 'package:flutter/material.dart';

//Class for Hour indicator rotation
class HourIndicator extends StatelessWidget {
  const HourIndicator({
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
          offset: const Offset(0, 25),
          child: Container(
            height: vHeight * 0.11,
            width: 6.0,
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
