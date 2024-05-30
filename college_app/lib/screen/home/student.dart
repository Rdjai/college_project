import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:college_app/modal/studentModel.dart';

class khatanahaikarale extends StatefulWidget {
  const khatanahaikarale({Key? key});

  @override
  State<khatanahaikarale> createState() => _khatanahaikaraleState();
}

class _khatanahaikaraleState extends State<khatanahaikarale> {
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.all(18.0),
              color: Colors.white,
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
            ),
          );
        }
      },
    );
  }
}
