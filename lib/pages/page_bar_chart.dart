import 'package:analog_clock/models/time_range_model.dart';
import 'package:analog_clock/utils/colors.dart';
import 'package:analog_clock/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//For showing barchart after create alarm
class BarChartPage extends StatelessWidget {
  const BarChartPage({
    Key? key,
    required this.objTimeRange,
  }) : super(key: key);

  final List<TimeRange> objTimeRange;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TimeRange, String>> series = [
      charts.Series(
        id: "barchart_notification",
        data: objTimeRange,
        domainFn: (TimeRange series, _) => series.payload!,
        measureFn: (TimeRange series, _) => series.diffTimeOpen,
      )
    ];
    return Scaffold(
      backgroundColor: baseBlue,
      appBar: CustomAppBar(strTitle: 'Bar Chart Time Difference'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
        child: Padding(
          padding: const EdgeInsets.all(
            10.0,
          ),
          child: Center(
            child: Container(
              height: 400.0,
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Expanded(
                child: charts.BarChart(
                  series,
                  animate: true,
                  behaviors: [
                    charts.ChartTitle('Date Time',
                        behaviorPosition: charts.BehaviorPosition.bottom,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea),
                    charts.ChartTitle('Seconds',
                        behaviorPosition: charts.BehaviorPosition.start,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
