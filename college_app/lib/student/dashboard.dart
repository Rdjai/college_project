import 'dart:convert';

import 'package:college_app/shared_preference_class_get_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentDashBoard extends StatefulWidget {
  final String email;
  final String pass;
  const StudentDashBoard({
    required String this.email,
    required String this.pass,
  });

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

TextEditingController _searchStudetnController = TextEditingController();

class _StudentDashBoardState extends State<StudentDashBoard> {
  late Future<StudentProfileResponse?> _futureStudentProfile;

  @override
  void initState() {
    super.initState();
    _futureStudentProfile = getStudentProfile(widget.email, widget.pass);
  }

  Future<StudentProfileResponse?> getStudentProfile(
      String emailId, String passstudent) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:3000/api/v1/student/getprofile?emailOrMobileNumber=$emailId&password=$passstudent'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return StudentProfileResponse.fromJson(responseBody);
      } else {
        print(
            'Failed to load student profile. Status code: ${response.statusCode}');
        print(response.body);
        return null;
      }
    } catch (error) {
      print('Error fetching student profile: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      body: Center(
        child: FutureBuilder<StudentProfileResponse?>(
          future: _futureStudentProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return _buildStudentProfile(snapshot.data!);
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }

  Widget _buildStudentProfile(StudentProfileResponse response) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        SizedBox(height: 16.0),
        Text(
          '${response.student.firstName} ${response.student.lastName}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          response.student.email,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

Widget studentprofile() {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return _buildWideContainers(context);
      } else {
        return _buildNarrowContainers(context);
      }
    },
  );
}

Widget _buildWideContainers(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildProfileCard(context),
              SizedBox(height: 16.0),
              _buildSettingsCard(context),
            ],
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          flex: 3,
          child: _buildBillsCard(context),
        ),
      ],
    ),
  );
}

Widget _buildNarrowContainers(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        _buildProfileCard(context),
        SizedBox(height: 16.0),
        _buildSettingsCard(context),
        SizedBox(height: 16.0),
        _buildBillsCard(context),
      ],
    ),
  );
}

Widget _buildProfileCard(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
                'assets/profile.jpg'), // Replace with your image asset
          ),
          SizedBox(height: 16.0),
          Text(
            'Sami Rahman',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 8.0),
          Text('sami.rahman2002@gmail.com'),
          SizedBox(height: 8.0),
          Text('+1 555-569-1236'),
        ],
      ),
    ),
  );
}

Widget _buildSettingsCard(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 8.0),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Edit Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

Widget _buildBillsCard(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Bills',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 8.0),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone Bill'),
            trailing: Text('Paid', style: TextStyle(color: Colors.green)),
          ),
          ListTile(
            leading: Icon(Icons.wifi),
            title: Text('Internet Bill'),
            trailing: Text('Unpaid', style: TextStyle(color: Colors.red)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('House Rent'),
            trailing: Text('Paid', style: TextStyle(color: Colors.green)),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Income Tax'),
            trailing: Text('Paid', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    ),
  );
}

class Document {
  String pic;
  String signatureImg;
  String marksheet10th;
  String marksheet12th;
  String? bachelorMarksheet;

  Document({
    required this.pic,
    required this.signatureImg,
    required this.marksheet10th,
    required this.marksheet12th,
    this.bachelorMarksheet,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      pic: json['pic'],
      signatureImg: json['signature_img'],
      marksheet10th: json['marksheet_10th'],
      marksheet12th: json['marksheet_12th'],
      bachelorMarksheet: json['bachelor_marksheet'],
    );
  }
}

class Department {
  String? name;

  Department({this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      name: json['name'],
    );
  }
}

class Student {
  Document documents;
  Department department;
  String id;
  String studentID;
  String firstName;
  String lastName;
  String fatherName;
  String motherName;
  int mobileNo;
  String email;
  String gender;
  String dob;
  String religion;
  String maritalStatus;
  String bloodGroup;
  String nationalId;
  String nationalIdNumber;
  String admissionDate;
  String currentAddress;
  List<String> education;
  int enrollmentNo;
  String password;
  List<dynamic> results;
  List<dynamic> achievements;
  List<dynamic> fees;

  Student({
    required this.documents,
    required this.department,
    required this.id,
    required this.studentID,
    required this.firstName,
    required this.lastName,
    required this.fatherName,
    required this.motherName,
    required this.mobileNo,
    required this.email,
    required this.gender,
    required this.dob,
    required this.religion,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.nationalId,
    required this.nationalIdNumber,
    required this.admissionDate,
    required this.currentAddress,
    required this.education,
    required this.enrollmentNo,
    required this.password,
    required this.results,
    required this.achievements,
    required this.fees,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      documents: Document.fromJson(json['documents']),
      department: Department.fromJson(json['department']),
      id: json['_id'],
      studentID: json['studentID'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      mobileNo: json['mobile_no'],
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      religion: json['religion'],
      maritalStatus: json['martial_status'],
      bloodGroup: json['blood_group'],
      nationalId: json['national_id'],
      nationalIdNumber: json['national_id_number'],
      admissionDate: json['addmission_date'],
      currentAddress: json['current_address'],
      education: List<String>.from(json['education']),
      enrollmentNo: json['enrollment_no'],
      password: json['password'],
      results: json['results'],
      achievements: json['achievements'],
      fees: json['fees'],
    );
  }
}

class StudentProfileResponse {
  String message;
  Student student;
  String token;
  bool success;

  StudentProfileResponse({
    required this.message,
    required this.student,
    required this.token,
    required this.success,
  });

  factory StudentProfileResponse.fromJson(Map<String, dynamic> json) {
    return StudentProfileResponse(
      message: json['message'],
      student: Student.fromJson(json['student']),
      token: json['token'],
      success: json['success'],
    );
  }
}
