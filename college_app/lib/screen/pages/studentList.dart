import 'dart:convert';
import 'package:college_app/screen/home/student.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:college_app/modal/studentModel.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late Future<List<StudentModel>> _futureStudents;

  Future<List<StudentModel>> getStudentData() async {
    var res = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      final List<dynamic> studentData = data['data'];
      List<StudentModel> students = [];
      for (var userData in studentData) {
        students.add(StudentModel.fromJson(userData));
      }
      return students;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureStudents = getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 9,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PerformanceCard(
              icon: Icons.group_sharp,
              subtitle: "Total student",
              title: "student",
            ),
            PerformanceCard(
              icon: Icons.local_library,
              subtitle: "Total Course",
              title: "Course",
            ),
            PerformanceCard(
              icon: Icons.group_add,
              subtitle: "Add student",
              title: "student",
            ),
          ],
        ),
        khatanahaikarale(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text("Left")],
        )
      ],
    );
  }
}

class PerformanceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  PerformanceCard(
      {required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 7,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, size: 60, color: Colors.blue),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
          ),
        ));
  }
}
