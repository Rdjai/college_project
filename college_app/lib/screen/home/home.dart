import 'package:college_app/screen/home/sfCartesianChart.dart';
import 'package:college_app/widgets/das_card.dart';
import 'package:college_app/screen/home/student.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 35, right: 18, left: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),

              Row(
                children: [
                  DashboardBard(
                      url: 'assets/img/student.png',
                      title: 'Pending Applications',
                      num: '12k'),
                  DashboardBard(
                      url: 'assets/img/teacher.png',
                      title: 'Active Students',
                      num: '12k'),
                  DashboardBard(
                      url: "assets/img/student.png",
                      title: 'Active Staffs',
                      num: '35'),
                  DashboardBard(
                      url: "assets/img/money.webp",
                      title: 'Total earn',
                      num: '90k'),
                ],
              ),
              sfCertensianChart(),
              const Text("Student List And Chart Acourding Department",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),

              Row(
                children: [
                  const Expanded(child: khatanahaikarale()),
                  Expanded(child: _cerculerchart(context))
                ],
              ),
              const SizedBox(
                height: 60,
              )
              // InputArea()
            ],
          ),
        ),
      ),
    );
  }
}

Widget _cerculerchart(BuildContext context) {
  final List<_PieData> chartData = [
    _PieData('Bca', 250),
    _PieData('Mca', 38),
    _PieData('Bba', 34),
    _PieData('Mba', 52)
  ];
  return Center(
      child: SfCircularChart(
          title: ChartTitle(text: 'Number of student'),
          legend: Legend(isVisible: true),
          series: <PieSeries<_PieData, String>>[
        PieSeries<_PieData, String>(
            explode: true,
            explodeIndex: 0,
            dataSource: chartData,
            xValueMapper: (_PieData data, _) => data.xData,
            yValueMapper: (_PieData data, _) => data.yData,
            dataLabelMapper: (_PieData data, _) => data.text,
            dataLabelSettings: const DataLabelSettings(isVisible: true)),
      ]));
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  String? text;
}
