import 'package:college_app/widgets/das_card.dart';
import 'package:college_app/screen/home/student.dart';
import 'package:college_app/screen/home/teacherlist.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Dashboard",
                textAlign: TextAlign.left,
                style: TextStyle(
                  // color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
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
            const Row(
              children: [
                Expanded(child: StudentlistWidget()),
                Expanded(child: teacherListWidget())
              ],
            ),
            // InputArea()
          ],
        ),
      ),
    );
  }
}
