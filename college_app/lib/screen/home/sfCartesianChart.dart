import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class sfCertensianChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCartesianChart(
        title: ChartTitle(text: 'Student Analysis'),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries>[
          LineSeries<SalesData, double>(
            name: 'Student',
            dataSource: getChartData(),
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
        ],
        primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '{value}K',
        ),
      ),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2015, 25),
      SalesData(2016, 12),
      SalesData(2017, 24),
      SalesData(2018, 18),
      SalesData(2019, 30),
      SalesData(2020, 10),
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
