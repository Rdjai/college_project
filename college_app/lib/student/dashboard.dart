import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentDashBoard extends StatefulWidget {
  String emailId;
  String passStudent;

  StudentDashBoard(String this.emailId, String this.passStudent);

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
  Future<Student> fetchStudent() async {
    final response = await http.get(
      Uri.parse(
        'http://localhost:3000/api/v1/student/getprofile?emailOrMobileNumber=${Uri.encodeComponent(widget.emailId)}&password=${Uri.encodeComponent(widget.passStudent)}',
      ),
    );

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load student data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Student>(
        future: fetchStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final student = snapshot.data!;
            return DashboardScreen(student: student);
          }
        },
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final Student student;

  DashboardScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Row(
        children: [
          NavigationDrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(student: student),
                    SizedBox(height: 20),
                    EducationSection(education: student.student!.education),
                    SizedBox(height: 20),
                    FeeHistorySection(fees: student.student!.fees),
                    SizedBox(height: 20),
                    AddressSection(
                        currentAddress: student.student!.currentAddress ?? ""),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final Student student;

  Header({required this.student});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(student.student!.documents!.pic ?? ''),
          radius: 40,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${student.student!.firstName}!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            Text(student.student!.email ?? ''),
          ],
        ),
      ],
    );
  }
}

class EducationSection extends StatelessWidget {
  final List<String> education;

  EducationSection({required this.education});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Education',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            for (var edu in education) Text(edu),
          ],
        ),
      ),
    );
  }
}

class FeeHistorySection extends StatelessWidget {
  final List<dynamic> fees;

  FeeHistorySection({required this.fees});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fee Payment History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Date',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    TableCell(
                        child: Text('Amount Paid',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    TableCell(
                        child: Text('Description',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                for (var fee in fees)
                  TableRow(
                    children: [
                      TableCell(child: Text(fee['date'])),
                      TableCell(child: Text('\$${fee['amount']}')),
                      TableCell(child: Text(fee['description'])),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddressSection extends StatelessWidget {
  final String currentAddress;

  AddressSection({required this.currentAddress});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(currentAddress),
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment Info'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Courses'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
        ],
      ),
    );
  }
}

class Student {
  Student({
    required this.message,
    required this.student,
    required this.token,
    required this.success,
  });

  final String? message;
  final StudentClass? student;
  final String? token;
  final bool? success;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      message: json["message"],
      student: json["student"] == null
          ? null
          : StudentClass.fromJson(json["student"]),
      token: json["token"],
      success: json["success"],
    );
  }
}

class StudentClass {
  StudentClass({
    required this.documents,
    required this.department,
    required this.id,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.fatherName,
    required this.motherName,
    required this.mobileNo,
    required this.email,
    required this.gender,
    required this.dob,
    required this.religion,
    required this.martialStatus,
    required this.bloodGroup,
    required this.nationalId,
    required this.nationalIdNumber,
    required this.addmissionDate,
    required this.currentAddress,
    required this.education,
    required this.enrollmentNo,
    required this.password,
    required this.results,
    required this.achievements,
    required this.fees,
    required this.v,
  });

  final Documents? documents;
  final Department? department;
  final String? id;
  final String? studentId;
  final String? firstName;
  final String? lastName;
  final String? fatherName;
  final String? motherName;
  final int? mobileNo;
  final String? email;
  final String? gender;
  final DateTime? dob;
  final String? religion;
  final String? martialStatus;
  final String? bloodGroup;
  final String? nationalId;
  final int? nationalIdNumber;
  final DateTime? addmissionDate;
  final String? currentAddress;
  final List<String> education;
  final int? enrollmentNo;
  final String? password;
  final List<dynamic> results;
  final List<dynamic> achievements;
  final List<dynamic> fees;
  final int? v;

  factory StudentClass.fromJson(Map<String, dynamic> json) {
    return StudentClass(
      documents: json["documents"] == null
          ? null
          : Documents.fromJson(json["documents"]),
      department: json["department"] == null
          ? null
          : Department.fromJson(json["department"]),
      id: json["_id"],
      studentId: json["studentID"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      fatherName: json["fatherName"],
      motherName: json["motherName"],
      mobileNo: json["mobile_no"],
      email: json["email"],
      gender: json["gender"],
      dob: DateTime.tryParse(json["dob"] ?? ""),
      religion: json["religion"],
      martialStatus: json["martial_status"],
      bloodGroup: json["blood_group"],
      nationalId: json["national_id"],
      nationalIdNumber: json["national_id_number"],
      addmissionDate: DateTime.tryParse(json["addmission_date"] ?? ""),
      currentAddress: json["current_address"],
      education: json["education"] == null
          ? []
          : List<String>.from(json["education"]!.map((x) => x)),
      enrollmentNo: json["enrollment_no"],
      password: json["password"],
      results: json["results"] == null
          ? []
          : List<dynamic>.from(json["results"]!.map((x) => x)),
      achievements: json["achievements"] == null
          ? []
          : List<dynamic>.from(json["achievements"]!.map((x) => x)),
      fees: json["fees"] == null
          ? []
          : List<dynamic>.from(json["fees"]!.map((x) => x)),
      v: json["__v"],
    );
  }
}

class Department {
  Department({
    required this.name,
  });

  final dynamic name;

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      name: json["name"],
    );
  }
}

class Documents {
  Documents({
    required this.pic,
    required this.signatureImg,
    required this.marksheet10Th,
    required this.marksheet12Th,
    required this.bachelorMarksheet,
  });

  final String? pic;
  final String? signatureImg;
  final String? marksheet10Th;
  final String? marksheet12Th;
  final String? bachelorMarksheet;

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      pic: json["pic"],
      signatureImg: json["signature_img"],
      marksheet10Th: json["marksheet_10th"],
      marksheet12Th: json["marksheet_12th"],
      bachelorMarksheet: json["bachelor_marksheet"],
    );
  }
}
