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
      professorID: json['professorID'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobileNo: json['mobile_no'],
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      religion: json['religion'],
      martialStatus: json['martial_status'],
      nationalID: json['national_id'],
      nationalIDNumber: json['national_id_number'],
      departments: (json['departments'] as List)
          .map((dept) => Department.fromJson(dept))
          .toList(),
      semAndSubs: (json['sem_and_subs'] as List)
          .map((semAndSub) => SemesterSubject.fromJson(semAndSub))
          .toList(),
      joiningDate: json['joining_date'],
      currentAddress: CurrentAddress.fromJson(json['current_address']),
      qualifications: (json['qualifications'] as List)
          .map((qual) => Qualification.fromJson(qual))
          .toList(),
      documents: Documents.fromJson(json['documents']),
      achievements: (json['achievements'] as List)
          .map((achv) => Achievement.fromJson(achv))
          .toList(),
      salary: json['salary'],
      password: json['password'],
      position: json['position'],
    );
  }
}

class Department {
  String name;
  String depID;

  Department({required this.name, required this.depID});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      name: json['name'],
      depID: json['depID'],
    );
  }
}

class SemesterSubject {
  String semesterName;
  String semesterID;
  String subjectName;

  SemesterSubject(
      {required this.semesterName,
      required this.semesterID,
      required this.subjectName});

  factory SemesterSubject.fromJson(Map<String, dynamic> json) {
    return SemesterSubject(
      semesterName: json['semester']['name'],
      semesterID: json['semester']['id'],
      subjectName: json['subject']['name'],
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
      category: json['category'],
      professorID: json['professor_id'],
      houseNo: json['house_no'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
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
      professorID: json['professor_id'],
      instituteName: json['institute_name'],
      qualificationName: json['qlfc_name'],
      completionYear: json['completion_year'],
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
      pic: json['pic'],
      signatureImg: json['signature_img'],
      resumeOrCv: json['resume_or_cv'],
      bankDetails: json['bankDetails'],
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
      name: json['name'],
      achvmtsDesc: json['achmtsDesc'],
      digitalLink: json['digitalLink'],
    );
  }
}
