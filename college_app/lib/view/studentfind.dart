import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Student {
  final int id;
  final String name;
  final String designation;
  final String image;

  Student({
    required this.id,
    required this.name,
    required this.designation,
    required this.image,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      designation: json['designation'],
      image: json['image'],
    );
  }
}

class StudentFindScreen extends StatefulWidget {
  const StudentFindScreen({Key? key}) : super(key: key);

  @override
  State<StudentFindScreen> createState() => _StudentFindScreenState();
}

class _StudentFindScreenState extends State<StudentFindScreen> {
  List<Student> _allStudents = [];
  List<Student> _foundStudents = [];

  Future<void> _fetchAllStudents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      throw Exception('No token found');
    }
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/v1/admin/get/allStudents'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('students') &&
          jsonResponse['students'] != null) {
        List<dynamic> studentsData = jsonResponse['students'];
        _allStudents =
            studentsData.map((data) => Student.fromJson(data)).toList();
        setState(() {
          _foundStudents = _allStudents;
        });
      } else {
        throw Exception('No student data found');
      }
    } else {
      throw Exception('Failed to load students: ${response.statusCode}');
    }
  }

  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        _foundStudents = _allStudents;
      });
    } else {
      setState(() {
        _foundStudents = _allStudents
            .where((student) => student.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Student List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: 'Search',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundStudents.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundStudents.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage(_foundStudents[index].image),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(_foundStudents[index].name),
                          subtitle: Text(_foundStudents[index].designation),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'No results found. Please try a different search.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
