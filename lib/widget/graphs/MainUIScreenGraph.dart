import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/utils/GraphUtils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainUIScreenGraph extends StatelessWidget {
  final DeviceDataProvider provider;
  MainUIScreenGraph(this.provider);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SfCartesianChart(
          // Initialize category axis
          primaryXAxis: DateTimeAxis(
            minimum: provider.min,
            maximum: provider.max,
          ),
          primaryYAxis: NumericAxis(),
          trackballBehavior: TrackballBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
          ),
          zoomPanBehavior:ZoomPanBehavior(
              enablePinching: false,
              enablePanning: false,
          ),
          series: <ChartSeries>[
            GraphDataUtils.getSplineDate(
                provider.pHData, Colors.blue, provider.animationDuration),
          ],
          selectionType: SelectionType.point,
        ),
      ],
    );
  }
}
