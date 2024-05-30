import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StudentFindScreen extends StatefulWidget {
  const StudentFindScreen({Key? key}) : super(key: key);

  @override
  State<StudentFindScreen> createState() => _StudentFindScreenState();
}

class _StudentFindScreenState extends State<StudentFindScreen> {
  List<Student> _allStudents = [];
  List<Student> _foundStudents = [];

  @override
  void initState() {
    super.initState();
    _fetchAllStudents();
  }

  Future<void> _fetchAllStudents() async {
    try {
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
        print('Response JSON: $jsonResponse'); // Debug print

        if (jsonResponse.containsKey('students') &&
            jsonResponse['students'] != null) {
          List<dynamic> studentsData = jsonResponse['students'];
          print('Students Data: $studentsData'); // Debug print
          setState(() {
            _allStudents =
                studentsData.map((data) => Student.fromJson(data)).toList();
            _foundStudents = _allStudents;
          });
          print(_foundStudents);
        } else {
          throw Exception('No student data found');
        }
      } else {
        throw Exception('Failed to load students: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching students: $e'); // Debug print
      _showErrorDialog('Failed to load students.');
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Student> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allStudents;
    } else {
      results = _allStudents
          .where((student) =>
              student.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundStudents = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User List'),
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
                hintText: "Search",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                          subtitle:
                              Text('${_foundStudents[index].designation}'),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found. Please try a different search.',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('College Management System Notification'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class Student {
  final String id;
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
      id: json['_id'],
      name: "${json['firstName']} ${json['lastName']}",
      designation: json['department']['name'] ?? 'No designation',
      image: json['documents']['pic'],
    );
  }
}
