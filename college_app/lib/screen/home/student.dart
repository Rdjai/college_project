import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:college_app/modal/studentModel.dart';

class StudentlistWidget extends StatefulWidget {
  const StudentlistWidget({Key? key});

  @override
  State<StudentlistWidget> createState() => _StudentlistWidgetState();
}

class _StudentlistWidgetState extends State<StudentlistWidget> {
  // ignore: unused_field
  late Future<List<StudentModel>> _futureStudents;

  Future<List<StudentModel>> GetstudentData() async {
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
    _futureStudents = GetstudentData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StudentModel>>(
      future: GetstudentData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.map((student) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(student.avatar),
                  ),
                  title: Text(student.firstName),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
