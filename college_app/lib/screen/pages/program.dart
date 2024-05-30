import 'dart:convert';
import 'package:college_app/modal/Professor_profile_modal.dart';
import 'package:college_app/screen/addnew/proffesor_add.dart';
import 'package:college_app/screen/home/student.dart';
import 'package:college_app/screen/pages/studentList.dart';
import 'package:college_app/widgets/department_Data.dart';
import 'package:college_app/widgets/dob.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AcadimicsCourse extends StatefulWidget {
  const AcadimicsCourse({super.key});

  @override
  State<AcadimicsCourse> createState() => _AcadimicsCourseState();
}

TextEditingController _departmentConntroller = TextEditingController();
TextEditingController _semesterConntroller = TextEditingController();
late String selectedDepartment;

class _AcadimicsCourseState extends State<AcadimicsCourse> {
  late String eventdate;
  late Future<List<Professor>> futureProfessors;

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

  List<dynamic> _departments = [];
  bool _isLoading = true;
  bool _isLoadingProfessors = true;

  Future<void> GetcourseDetails() async {
    try {
      var res = await http.get(
        Uri.parse(
            "http://localhost:3000/api/v1/departments/get/all_departments"),
      );

      if (res.statusCode == 200) {
        print(res.body);
        final List<dynamic> responseData = jsonDecode(res.body)['departments'];
        setState(() {
          _departments =
              responseData.map((data) => Program.fromJson(data)).toList();
          _isLoading = false;
        });
      } else {
        print('Failed to load departments. Status code: ${res.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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

  Future<List<Professor>> _fetchProfessors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      throw Exception('No token found');
    }
    final response = await http.get(
        Uri.parse('http://localhost:3000/api/v1/admin/get/all_professors'),
        headers: {
          'Authorization': 'Bearer $token',
        });
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('prfrs') && jsonResponse['prfrs'] != null) {
        List<dynamic> professorsData = jsonResponse['prfrs'];
        return professorsData.map((data) => Professor.fromJson(data)).toList();
      } else {
        throw Exception('No data found');
      }
    } else {
      throw Exception('Failed to load professors');
    }
  }

  @override
  void initState() {
    super.initState();
    GetcourseDetails();
    futureProfessors = _fetchProfessors();
  }

  @override
  Widget build(BuildContext context) {
    print(futureProfessors);
    print(
        "getpppoo akjdhflsajdhf;ljhdaf lajdhflj; ${futureProfessors.toString()}");
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PerformanceCard(
                  title: "1220", subtitle: "All student", icon: Icons.person),
              FutureBuilder<List<Professor>>(
                future: futureProfessors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return PerformanceCard(
                        title: 'Loading...',
                        subtitle: "Professors",
                        icon: Icons.person);
                  } else if (snapshot.hasError) {
                    return PerformanceCard(
                        title: 'Error',
                        subtitle: "Professors",
                        icon: Icons.error);
                  } else if (snapshot.hasData) {
                    return PerformanceCard(
                        title: snapshot.data!.length.toString(),
                        subtitle: "Professors",
                        icon: Icons.person);
                  } else {
                    return PerformanceCard(
                        title: '0', subtitle: "Professors", icon: Icons.person);
                  }
                },
              ),
              GestureDetector(
                child: PerformanceCard(
                    title: _departments.length.toString(),
                    subtitle: "Our Courses",
                    icon: Icons.menu_book),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CourseWidget(),
              ),
              Expanded(
                child: Column(
                  children: [
                    _EventPushPage(),
                    _PushSemisterForDeparment(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget CourseWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _departments.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: _departments.length,
                itemBuilder: (context, index) {
                  // Assuming each item in _departments is a Program object
                  final department = _departments[index] as Program;
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                      title: Text(department.name),
                      subtitle: Text(
                          'ID: ${department.id}'), // Example of additional info
                    ),
                  );
                },
              )
            : const Text(
                'No results found. Please try a different search.',
                style: TextStyle(fontSize: 24),
              ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _EventPushPage() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              _buildTextField(
                  "Department", "Enter Department", _departmentConntroller),
              ElevatedButton(
                  onPressed: () {
                    final String departmentName =
                        _departmentConntroller.text.trim();
                    if (departmentName.isNotEmpty) {
                      departmentCreate(departmentName, context);
                    }
                  },
                  child: Text("Create Department"))
            ],
          ),
        ),
      ),
    );
  }

  Widget _PushSemisterForDeparment() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              _buildTextField(
                  "Semester", "create semester", _semesterConntroller),
              DepartmentData(
                onChanged: (String department) {
                  selectedDepartment = department;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    final String departmentName =
                        _semesterConntroller.text.trim();
                    if (departmentName.isNotEmpty) {
                      semesterCreate(departmentName, context);
                    }
                  },
                  child: Text("Create semester"))
            ],
          ),
        ),
      ),
    );
  }

  // void _showErrorDialog(BuildContext context, String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('College Management System Notification'),
  //         content: Text(message),
  //         actions: [
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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

class Semester {
  String name;
  String id;
  String semesterId;

  Semester({required this.name, required this.id, required this.semesterId});

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      name: json['name'],
      id: json['id'],
      semesterId: json['_id'],
    );
  }
}

class Program {
  String id;
  String name;
  List<Semester> semesters;
  List<dynamic> events; // You can replace `dynamic` with the appropriate type

  Program(
      {required this.id,
      required this.name,
      required this.semesters,
      required this.events});

  factory Program.fromJson(Map<String, dynamic> json) {
    List<Semester> semesters = [];
    if (json['semesters'] != null) {
      semesters = List<Semester>.from(
          json['semesters'].map((semester) => Semester.fromJson(semester)));
    }
    return Program(
      id: json['_id'],
      name: json['name'],
      semesters: semesters,
      events: json['events'],
    );
  }
}

class Professor {
  String professorID;
  String firstName;
  String lastName;
  int mobileNo;
  String email;
  String gender;
  String dob;
  String religion;
  String martialStatus;
  String nationalID;
  int nationalIDNumber;
  List<Department> departments;
  List<SemesterSubject> semAndSubs;
  String joiningDate;
  CurrentAddress currentAddress;
  List<Qualification> qualifications;
  Documents documents;
  List<Achievement> achievements;
  int salary;
  String password;
  String position;

  Professor({
    required this.professorID,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.email,
    required this.gender,
    required this.dob,
    required this.religion,
    required this.martialStatus,
    required this.nationalID,
    required this.nationalIDNumber,
    required this.departments,
    required this.semAndSubs,
    required this.joiningDate,
    required this.currentAddress,
    required this.qualifications,
    required this.documents,
    required this.achievements,
    required this.salary,
    required this.password,
    required this.position,
  });

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      professorID: json['professorID'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobileNo: json['mobile_no'] ?? 0,
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      religion: json['religion'] ?? '',
      martialStatus: json['martial_status'] ?? '',
      nationalID: json['national_id'] ?? '',
      nationalIDNumber: json['national_id_number'] ?? 0,
      departments: (json['departments'] as List?)
              ?.map((dept) => Department.fromJson(dept))
              .toList() ??
          [],
      semAndSubs: (json['sem_and_subs'] as List?)
              ?.map((semAndSub) => SemesterSubject.fromJson(semAndSub))
              .toList() ??
          [],
      joiningDate: json['joining_date'] ?? '',
      currentAddress: json['current_address'] != null
          ? CurrentAddress.fromJson(json['current_address'])
          : CurrentAddress(
              category: '',
              professorID: '',
              houseNo: 0,
              street: '',
              city: '',
              state: '',
              postalCode: 0,
            ),
      qualifications: (json['qualifications'] as List?)
              ?.map((qual) => Qualification.fromJson(qual))
              .toList() ??
          [],
      documents: json['documents'] != null
          ? Documents.fromJson(json['documents'])
          : Documents(
              pic: '',
              signatureImg: '',
              resumeOrCv: '',
              bankDetails: '',
            ),
      achievements: (json['achievements'] as List?)
              ?.map((achv) => Achievement.fromJson(achv))
              .toList() ??
          [],
      salary: json['salary'] ?? 0,
      password: json['password'] ?? '',
      position: json['position'] ?? '',
    );
  }
}

class Department {
  String name;
  String depID;

  Department({required this.name, required this.depID});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      name: json['name'] ?? '',
      depID: json['_id'] ?? '',
    );
  }
}

class SemesterSubject {
  String semesterName;
  String semesterID;
  String subjectName;

  SemesterSubject({
    required this.semesterName,
    required this.semesterID,
    required this.subjectName,
  });

  factory SemesterSubject.fromJson(Map<String, dynamic> json) {
    return SemesterSubject(
      semesterName: json['semester']['name'] ?? '',
      semesterID: json['semester']['_id'] ?? '',
      subjectName: json['subject']['name'] ?? '',
    );
  }
}

class CurrentAddress {
  String category;
  String professorID;
  int houseNo;
  String street;
  String city;
  String state;
  int postalCode;

  CurrentAddress({
    required this.category,
    required this.professorID,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  factory CurrentAddress.fromJson(Map<String, dynamic> json) {
    return CurrentAddress(
      category: json['category'] ?? '',
      professorID: json['professor_id'] ?? '',
      houseNo: json['house_no'] ?? 0,
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postal_code'] ?? 0,
    );
  }
}

class Qualification {
  String professorID;
  String instituteName;
  String qualificationName;
  int completionYear;

  Qualification({
    required this.professorID,
    required this.instituteName,
    required this.qualificationName,
    required this.completionYear,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      professorID: json['professor_id'] ?? '',
      instituteName: json['insitute_name'] ?? '',
      qualificationName: json['qlfc_name'] ?? '',
      completionYear: int.parse(json['completion_year'] ?? '0'),
    );
  }
}

class Documents {
  String pic;
  String signatureImg;
  String resumeOrCv;
  String bankDetails;

  Documents({
    required this.pic,
    required this.signatureImg,
    required this.resumeOrCv,
    required this.bankDetails,
  });

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      pic: json['pic'] ?? '',
      signatureImg: json['signature_img'] ?? '',
      resumeOrCv: json['resume_or_cv'] ?? '',
      bankDetails: json['bankDetails'] ?? '',
    );
  }
}

class Achievement {
  String name;
  String achvmtsDesc;
  String digitalLink;

  Achievement({
    required this.name,
    required this.achvmtsDesc,
    required this.digitalLink,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      name: json['name'] ?? '',
      achvmtsDesc: json['achmtsDesc'] ?? '',
      digitalLink: json['digitalLink'] ?? '',
    );
  }
}
