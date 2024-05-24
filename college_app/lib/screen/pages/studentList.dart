import 'dart:convert';
import 'package:flutter/material.dart';
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
    return FutureBuilder<List<StudentModel>>(
      future: _futureStudents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(student.avatar),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(student.firstName + student.lastName),
                      Text(student.email),
                      Text("Bca")
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text('No students found'),
          );
        }
      },
    );
  }
}
