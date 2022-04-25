import 'package:flutter/material.dart';

//Class for Second indicator rotation
class SecondIndicator extends StatelessWidget {
  const SecondIndicator({
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
          offset: const Offset(0, 45),
          child: Container(
            height: vHeight * 0.17,
            width: 1.0,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(
                0.8,
              ),
              borderRadius: BorderRadius.circular(
                32.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
