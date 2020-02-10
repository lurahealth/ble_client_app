import 'package:ble_client_app/providers/DeviceDataProvider.dart';
import 'package:ble_client_app/utils/GraphUtils.dart';
import 'package:ble_client_app/utils/StyleUtils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PHGraph extends StatelessWidget {
  final DeviceDataProvider provider;

  PHGraph(this.provider);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SfCartesianChart(
          plotAreaBorderColor: LURA_BLUE,
          borderColor: LURA_BLUE,
          backgroundColor: LURA_BLUE,
          // Initialize category axis
          primaryXAxis: DateTimeAxis(
              minimum: provider.min,
              maximum: provider.max,
              axisLine: AxisLine(color: LURA_BLUE),
              majorGridLines: MajorGridLines(color: LURA_BLUE)),
          primaryYAxis: NumericAxis(
            majorGridLines: MajorGridLines(color: LURA_BLUE),
            axisLine: AxisLine(color: LURA_BLUE),
          ),
          crosshairBehavior: CrosshairBehavior(
            lineColor: Colors.white,
            enable: true,
            activationMode: ActivationMode.singleTap,
          ),
//          trackballBehavior: TrackballBehavior(
//              enable: true,
//              activationMode: ActivationMode.singleTap,
//          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: false,
            enablePanning: false,
          ),
          series: <ChartSeries>[
            GraphDataUtils.getAreaChartDate(
                provider.pHData, Colors.white, provider.animationDuration),
          ],
          selectionType: SelectionType.point,
        ),
      ],
    );
  }
}
