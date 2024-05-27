import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfessorProfile extends StatefulWidget {
  @override
  _ProfessorProfileState createState() => _ProfessorProfileState();
}

class _ProfessorProfileState extends State<ProfessorProfile> {
  late Future<List<Professor>> futureProfessors;

  @override
  void initState() {
    super.initState();
    futureProfessors = _fetchProfessors();
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

    if (response.statusCode == 200) {
      print(response.body);
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: FutureBuilder<List<Professor>>(
        future: futureProfessors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print(snapshot);
            return const Center(child: Text('No professors found'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ProfessorCard(professor: snapshot.data![index]);
              },
            );
          }
        },
      ),
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

class ProfessorCard extends StatelessWidget {
  final Professor professor;

  ProfessorCard({required this.professor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(professor.documents.pic),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${professor.firstName} ${professor.lastName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Position: ${professor.position}',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Email: ${professor.email}',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
