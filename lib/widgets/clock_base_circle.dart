import 'package:analog_clock/utils/painter.dart';
import 'package:analog_clock/utils/colors.dart';
import 'package:flutter/material.dart';

class ClockBaseCircle extends StatelessWidget {
  ClockBaseCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vHeight = MediaQuery.of(context).size.height;
    final vWidth = MediaQuery.of(context).size.width;

    return Container(
      height: vHeight * 0.5,
      width: vWidth * 0.7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: <Color>[
            grey3VectoraColor,
            grey2VectoraColor,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: grey2VectoraColor.withOpacity(.9),
            blurRadius: 32.0,
            spreadRadius: 5.0,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: grey3VectoraColor.withOpacity(.9),
            blurRadius: 32.0,
            spreadRadius: 5.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          30.0,
        ),
        child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white60,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 26.0,
              ),
              child: CustomPaint(
                painter: ClockDialPainter(vWidth),
              ),
            )),
      ),
    );
  }
}
