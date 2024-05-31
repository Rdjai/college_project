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
    return Scaffold(
      body: Material(
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
                    Expanded(child: EventsSection()),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle fees payment action
          print('Fees payment button pressed');
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.currency_rupee,
          color: Colors.white,
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

class EventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Events',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            EventTile(
              title: 'Ground Assembly',
              description:
                  'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
              time: 'Today 6pm',
              isUnread: true,
            ),
            Divider(),
            EventTile(
              title: 'Seminar Hall Notice',
              description:
                  'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
              time: 'Tomorrow 11am',
              isUnread: true,
            ),
            Divider(),
            EventTile(
              title: 'Tect Fest',
              description:
                  'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
              time: 'Yesterday 1pm',
              isUnread: false,
            ),
          ],
        ),
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isUnread;

  EventTile(
      {required this.title,
      required this.description,
      required this.time,
      required this.isUnread});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: TextStyle(color: Colors.grey)),
          if (isUnread)
            Container(
              margin: EdgeInsets.only(top: 4),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: Colors.red,
              child: Text(
                'Unread',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
