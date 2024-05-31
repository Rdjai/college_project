// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:college_app/screen/addnew/proffesor_add.dart';
import 'package:college_app/screen/home/home.dart';
import 'package:college_app/screen/addnew/newragister.dart';
import 'package:college_app/screen/pages/adminprofile.dart';
import 'package:college_app/screen/pages/eventpage.dart';
import 'package:college_app/screen/pages/professor_profile.dart';
import 'package:college_app/screen/pages/program.dart';
import 'package:college_app/screen/pages/studentList.dart';
import 'package:college_app/screen/splash.dart';
import 'package:college_app/view/studentfind.dart';
import 'package:college_app/widgets/department_Data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class mainHomePage extends StatefulWidget {
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePageState();
}

TextEditingController _departmentController = TextEditingController();
TextEditingController _createSemesterController = TextEditingController();
late String selectedDepartment;

class _mainHomePageState extends State<mainHomePage> {
  final Map<String, Widget> _screen = {
    'Home': HomeWidget(),
    'New_Registration': const ResponsiveForm(),
    'add_professor': professoradd(),
    'Student_List': const StudentListPage(),
    'admindetails': DetailsOfAdmin(),
    'teacherProfile': ProfessorProfile(),
    'studentDetails': StudentFindScreen(),
    "eventPageHere": const EventPage(),
    "courseprogramr": const AcadimicsCourse(),
  };
  String _selectedScreen = 'Home';

  Future<void> printToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
    } else {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Splash(),
          ),
        );
      }
    }
  }

  Future<void> departmentCreate(String department, BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final res = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin/department/add'),
        body: jsonEncode({
          'departmentName': department,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> response = jsonDecode(res.body);

      if (res.statusCode == 200) {
        // Successfully created department
        if (mounted) {
          Navigator.pop(context); // Close the dialog
        }
      } else {
        // Show error message
        if (mounted) {
          _showErrorDialog(response['message']);
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    }
  }

  Future<void> semesterCreate(String semesterName, BuildContext context) async {
    debugPrint(
        'Creating semester: $semesterName in department: $selectedDepartment');
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      final res = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin/semester/add'),
        body: jsonEncode({
          'departmentName': selectedDepartment,
          'semester': semesterName,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response status: ${res.statusCode}');
      final Map<String, dynamic> response = jsonDecode(res.body);
      debugPrint('Response body: $response');

      if (res.statusCode == 200) {
        // Successfully created semester
        if (mounted) {
          Navigator.pop(context); // Close the dialog
        }
      } else {
        // Show error message
        if (mounted) {
          _showErrorDialog(response['message']);
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF6F6F4),
        appBar: AppBar(
          elevation: 0.1,
          leading: Padding(
            padding: const EdgeInsets.all(7),
            child: Image.asset('assets/img/logo.png'),
          ),
          title: const Text(
            'Dr. MPS Group of Institution',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Row(
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        ListTile(
                          onTap: () {
                            setState(() {
                              _selectedScreen = 'Home';
                            });
                          },
                          leading: const CircleAvatar(
                            child: Icon(Icons.home),
                          ),
                          title: const Text('Dashboard'),
                        ),
                        ExpansionTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.account_balance),
                          ),
                          title: const Text('Admission'),
                          children: [
                            ListTile(
                              title: const Text('- Applications'),
                              onTap: () {},
                            ),
                            ListTile(
                              title: const Text('- New Registration'),
                              onTap: () {
                                setState(() {
                                  _selectedScreen = 'New_Registration';
                                });
                              },
                            ),
                            ListTile(
                              title: const Text('- Student List'),
                              onTap: () {
                                setState(() {
                                  _selectedScreen = 'Student_List';
                                });
                              },
                            ),
                          ],
                        ),
                        ExpansionTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.school),
                          ),
                          title: const Text('Academic'),
                          children: [
                            ListTile(
                              title: const Text('- Faculties'),
                              onTap: () {
                                setState(() {
                                  _selectedScreen = 'teacherProfile';
                                });
                              },
                            ),
                            ListTile(
                              title: const Text('- Programs'),
                              onTap: () {
                                setState(() {
                                  _selectedScreen = 'courseprogramr';
                                });
                              },
                            ),
                            ListTile(
                              title: const Text('- Event'),
                              onTap: () {
                                setState(() {
                                  _selectedScreen = 'eventPageHere';
                                });
                              },
                            ),
                            ListTile(
                              title: const Text('- Find Students'),
                              onTap: () {
                                setState(() {
                                  _selectedScreen = 'studentDetails';
                                });
                              },
                            ),
                          ],
                        ),
                        ExpansionTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.work_history),
                          ),
                          title: const Text('Assign Work'),
                          children: [
                            ListTile(
                              title: const Text('- Applications'),
                              onTap: () {},
                            ),
                            ListTile(
                              title: const Text('- New Registration'),
                              onTap: () {},
                            ),
                            ListTile(
                              title: const Text('- Student List'),
                              onTap: () {},
                            ),
                          ],
                        ),
                        ExpansionTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.create_rounded),
                          ),
                          title: const Text('Add'),
                          children: [
                            ListTile(
                              title: const Text('- Add Professor'),
                              onTap: () {
                                printToken();
                                setState(() {
                                  _selectedScreen = 'add_professor';
                                });
                              },
                            ),
                            ListTile(
                              title: const Text('- Department'),
                              onTap: () {
                                _showCreateDepartment();
                              },
                            ),
                            ListTile(
                              title: const Text('- Add Semester'),
                              onTap: () {
                                _showCreateSemester();
                              },
                            ),
                          ],
                        ),
                        ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: const Text('Profile'),
                          onTap: () {
                            setState(() {
                              _selectedScreen = 'admindetails';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: _screen[_selectedScreen]!,
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateDepartment() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Department'),
          content: TextField(
            controller: _departmentController,
            decoration:
                const InputDecoration(hintText: 'Enter department name'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                final String departmentName = _departmentController.text.trim();
                if (departmentName.isNotEmpty) {
                  departmentCreate(departmentName, context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showCreateSemester() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Semester'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _createSemesterController,
                decoration:
                    const InputDecoration(hintText: 'Enter semester name'),
              ),
              const SizedBox(height: 16.0),
              DepartmentData(
                onChanged: (String department) {
                  selectedDepartment = department;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                final String semesterName =
                    _createSemesterController.text.trim();
                if (semesterName.isNotEmpty && selectedDepartment != null) {
                  semesterCreate(semesterName, context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
