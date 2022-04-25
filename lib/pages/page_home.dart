import 'dart:async';
import 'dart:math';
import 'package:analog_clock/models/time_range_model.dart';
import 'package:analog_clock/service/notification.dart';
import 'package:analog_clock/pages/page_bar_chart.dart';
import 'package:analog_clock/widgets/alarm.dart';
import 'package:analog_clock/widgets/appbar.dart';
import 'package:analog_clock/widgets/digital_clock.dart';
import 'package:get/get.dart';
import 'package:analog_clock/utils/colors.dart';
import 'package:analog_clock/widgets/analog_clock.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double secondsAngle = 0;
  double minutesAngle = 0;
  double hoursAngle = 0;

  late double wheelSize;

  double degree = 0;
  int minute_chooser = 0;
  int hour_chooser = 0;

  late double radius;
  late AnimationController ctrl;

  final now = DateTime.now();
  Rx<DateTime> tempDateTime = DateTime.now().obs;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    listenNotification();

    wheelSize = 300;
    radius = wheelSize / 2;
    ctrl = AnimationController.unbounded(vsync: this);
    degree = ((now.minute / 60) * 360) + ((now.second / 60) * 6);
    minute_chooser = getMinuteChooser(degree);
    ctrl.value = degree;

    restoreTimer();
  }

  //Notification Listener
  void listenNotification() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  //onClickedNotification to show Notification
  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BarChartPage(
          objTimeRange: [
            TimeRange(
              payload!,
              DateTime.now().difference(DateTime.parse(payload)).inSeconds,
            ),
          ],
        ),
      ));

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

  //Reset Timer
  void restoreTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        secondsAngle = updateSecondsAngle(now.second);
        minutesAngle = updateMinuteAngle(now.minute);
        hoursAngle = updateHourAngle(now.hour);
      });
    });
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

  //Checking clockwise position from vertical perspective
  bool isVerticalClockWise(DragUpdateDetails details) {
    bool isPanUp = details.delta.dy <= 0.0;
    bool isPanDown = details.delta.dy > 0.0;

    bool isLeft = details.localPosition.dx <= radius;
    bool isRight = details.localPosition.dx > radius;

    return (isRight && isPanDown) || (isLeft && isPanUp);
  }

  //Checking clockwise position from horizontal perspective from drag gesture delta x
  bool isHorizontalClockWise(DragUpdateDetails details) {
    bool isTop = details.localPosition.dy <= radius;
    bool isBottom = details.localPosition.dy > radius;

    bool isPanLeft = details.delta.dx <= 0.0;
    bool isPanRight = details.delta.dx > 0.0;

    return (isTop && isPanRight) || (isBottom && isPanLeft);
  }

  //Drag gesture handler function for minute hand
  void updatePanHandler(DragUpdateDetails details) {
    double verticalChange = details.delta.dy.abs();
    double horizontalChange = details.delta.dx.abs();

    double verticalRotation =
        isVerticalClockWise(details) ? verticalChange : verticalChange * -1;

    double horizontalRotation = isHorizontalClockWise(details)
        ? horizontalChange
        : horizontalChange * -1;

    double rotationalChange = verticalRotation + horizontalRotation;

    double value = degree + (rotationalChange / 2);

    setState(() {
      degree = value > 0 ? value : 0;
      ctrl.value = degree;

      minute_chooser = getMinuteChooser(degree);
    });
  }

  //Get minute hand for show digital clock
  int getMinuteChooser(double degree) {
    var tempDegree = degree < 360 ? degree.roundToDouble() : degree - 360;
    var degrees = roundNearestTen(tempDegree.roundToDouble());

    return degrees ~/ 6 == 60 ? 0 : degrees ~/ 6;
  }

  @override
  Widget build(BuildContext context) {
    DateTime modifiedDateTime = DateTime(
        now.year, now.month, now.day, now.hour, minute_chooser, now.second);
    return Scaffold(
      appBar: CustomAppBar(
        strTitle: 'Analog Clock',
      ),
      backgroundColor: baseBlue,
      body: GestureDetector(
        onPanUpdate: updatePanHandler,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.all(
            24.0,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                24.0,
              ),
              topRight: Radius.circular(
                24.0,
              ),
            ),
            color: lightBlueVectoraColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Analog Clock
              AnalogClockWidget(
                hourAngle: updateHourAngle(modifiedDateTime.hour),
                minAngle: degreeToRadians(ctrl.value),
                secAngle: secondsAngle,
              ),
              //Digital Clock
              DigitalClockWidget(time: modifiedDateTime),
              // Alarm
              Alarm(
                hour: modifiedDateTime.hour,
                minute: minute_chooser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
