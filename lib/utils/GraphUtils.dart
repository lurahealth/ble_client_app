import 'package:ble_client_app/models/SplineData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphDataUtils {
  static FastLineSeries<SplineData, DateTime> getSplineDate(
      List<SplineData> splineData, Color color, double animationDuration) {
    return FastLineSeries<SplineData, DateTime>(
        dataSource: splineData,
        color: color,
        xValueMapper: (SplineData data, _) => data.timeStamp,
        yValueMapper: (SplineData data, _) => data.dataReading,
        animationDuration: animationDuration);
  }
}
