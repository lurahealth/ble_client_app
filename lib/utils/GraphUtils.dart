import 'package:ble_client_app/models/AreaChartData.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphDataUtils {
  static SplineSeries<AreaChartData, DateTime> getAreaChartDate(
      List<AreaChartData> splineData, Color color, double animationDuration) {
    return SplineSeries<AreaChartData, DateTime>(
        dataSource: splineData,
        color: color,
        xValueMapper: (AreaChartData data, _) => data.timeStamp,
        yValueMapper: (AreaChartData data, _) => data.dataReading,
        animationDuration: animationDuration,
        width: 5);
  }
}
