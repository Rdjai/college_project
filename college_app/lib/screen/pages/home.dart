// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:college_app/screen/addnew/proffesor_add.dart';
import 'package:college_app/screen/home/home.dart';
import 'package:college_app/screen/addnew/newragister.dart';
import 'package:college_app/screen/pages/adminprofile.dart';
import 'package:college_app/screen/pages/professor_profile.dart';
import 'package:college_app/screen/pages/studentList.dart';
import 'package:college_app/screen/pages/studentprofile.dart';
import 'package:college_app/screen/splash.dart';
import 'package:college_app/widgets/department_Data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class mainHomePage extends StatefulWidget {
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePageState();
}

TextEditingController _departmentController = TextEditingController();

TextEditingController _createSemisterController = TextEditingController();
late String selectedDepartment;

class _mainHomePageState extends State<mainHomePage> {
  final Map<String, Widget> _screen = {
    'mainHomePage': const HomeWidget(),
    'New_Registration': ResponsiveForm(),
    "add_professor": professoradd(),
    "Student_List": StudentListPage(),
    "admindetails": DetailsOfAdmin(),
    "teacherProfile": ProfessorProfile(),
    "studentDetails": const UserDetails()
  };
  String _selectedScreen = "Home";

  Future<void> printToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      print('Stored token: $token');
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Splash(),
          ));
    }
  }

  Future<void> departmentCreate(String Department, BuildContext context) async {
    try {
      print("Trying to send OTP");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final res = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin//department/add'),
        body: jsonEncode({
          'departmentName': Department,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> response = jsonDecode(res.body);

      print(res.statusCode);
      print("object");
      print(response["token"].toString());

      if (res.statusCode == 200) {
        // Successfully sent OTP, store the token and navigate to Verifyotp screen

        // Successfully sent OTP, navigate to Verifyotp screen
        Navigator.pop(context);
      } else {
        // Show error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('College Management System notification'),
              content: Text(response['message']),
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('College Management System notification'),
            content: Text(e.toString()),
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

  Future<void> semistercreate(String semesterName, BuildContext context) async {
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
        // Successfully created semester, handle navigation or display success message
        Navigator.pop(context); // Close the dialog
      } else {
        // Show error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('College Management System notification'),
              content: Text(response['message']),
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
    } catch (e) {
      // Handle exceptions
      debugPrint('Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('College Management System notification'),
            content: Text(e.toString()),
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

  @override
  Widget build(BuildContext context) {
    return Material(
        child: MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(241, 240, 243, 1),
        appBar: AppBar(
          elevation: 0.1,
          leading: Padding(
              padding: const EdgeInsets.all(7),
              child: Image.asset("assets/img/logo.png")),
          title: const Text(
            'Dr. Mps group of institution',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Row(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _selectedScreen = 'Home';
                      });
                    },
                    leading: const CircleAvatar(
                      child: Icon(Icons.home),
                    ),
                    title: const Text("Dashboard"),
                  ),
                  ExpansionTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.account_balance)),
                    title: const Text('Admission'),
                    children: [
                      ListTile(
                        title: const Text('- Applications'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('- New Registration'),
                        onTap: () {
                          // Handle submenu item 2 tap
                          setState(() {
                            _selectedScreen = "New_Registration";
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('- Student List'),
                        onTap: () {
                          setState(() {
                            _selectedScreen = "Student_List";
                          });
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading: const CircleAvatar(child: Icon(Icons.school)),
                    title: const Text('Academic'),
                    children: [
                      ListTile(
                        title: const Text('- faculties'),
                        onTap: () {
                          setState(() {
                            _selectedScreen = "teacherProfile";
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('- Programs'),
                        onTap: () {
                          // Handle submenu item 2 tap
                        },
                      ),
                      ListTile(
                        title: const Text('- Event'),
                        onTap: () {
                          // Handle submenu item 2 tap
                        },
                      ),
                      ListTile(
                        title: const Text('- Find Students'),
                        onTap: () {
                          setState(() {
                            _selectedScreen = "studentDetails";
                          });
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.work_history)),
                    title: const Text('Assign Work'),
                    children: [
                      ListTile(
                        title: const Text('- Applications'),
                        onTap: () {
                          // Handle submenu item 1 tap
                        },
                      ),
                      ListTile(
                        title: const Text('- New Registration'),
                        onTap: () {
                          // Handle submenu item 2 tap
                        },
                      ),
                      ListTile(
                        title: const Text('- Student List'),
                        onTap: () {
                          // Handle submenu item 2 tap
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.create_rounded)),
                    title: const Text('Add'),
                    children: [
                      ListTile(
                        title: const Text('- add professor'),
                        onTap: () {
                          // Handle submenu item 2 tap

                          printToken();
                          setState(() {
                            _selectedScreen = "add_professor";
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
                        title: const Text('- Add semister'),
                        onTap: () {
                          _showCreateSemester();
                          // Handle submenu item 2 tap
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text("Profile"),
                    onTap: () {
                      setState(() {
                        _selectedScreen = "admindetails";
                      });
                    },
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.phone),
                    ),
                    title: Text("Contact us"),
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.developer_mode),
                    ),
                    title: Text("Developers"),
                  ),
                ],
              ),
            ),
          )),
          Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromRGBO(241, 242, 251, 3),
                  child: _screen[_selectedScreen] ?? const HomeWidget(),
                ),
              ))
        ]),
      ),
    ));
  }

  void _showCreateDepartment() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create Department"),
          actions: [
            _buildTextField("Deparment name", "Enter department Name",
                _departmentController),
            SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
                onPressed: () {
                  departmentCreate(_departmentController.text, context);
                  Navigator.pop(context);
                },
                child: Text("Create Department"))
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
          title: Text("Create Semester"),
          actions: [
            Row(
              children: [
                Text(
                  "Select Department",
                  style: TextStyle(color: Colors.black),
                ),
                DepartmentData(
                  onChanged: (departmentName) {
                    setState(() {
                      selectedDepartment = departmentName;
                    });
                    debugPrint("Selected Department: $departmentName");
                  },
                )
              ],
            ),
            _buildTextField("Semester Name", "Enter Semester Name",
                _createSemisterController),
            SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
              onPressed: () async {
                debugPrint(
                    "Creating Semester: ${_createSemisterController.text}");
                await semistercreate(_createSemisterController.text, context);
              },
              child: Text("Create Semester"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController textControl) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: textControl,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
