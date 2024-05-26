class ProfileModelClass {
  String id;
  String adminID;
  String firstName;
  String lastName;
  String avatar;
  String fatherName;
  int mobileNo;
  String email;
  String gender;
  String dob;
  String religion;
  String martialStatus;
  String nationalId;
  int nationalIdNumber;
  String joiningDate;
  CurrentAddress currentAddress;
  List<Qualification> qualifications;
  Documents documents;
  List<Achievement> achievements;
  String password;

  ProfileModelClass({
    required this.id,
    required this.adminID,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.fatherName,
    required this.mobileNo,
    required this.email,
    required this.gender,
    required this.dob,
    required this.religion,
    required this.martialStatus,
    required this.nationalId,
    required this.nationalIdNumber,
    required this.joiningDate,
    required this.currentAddress,
    required this.qualifications,
    required this.documents,
    required this.achievements,
    required this.password,
  });

  factory ProfileModelClass.fromJson(Map<String, dynamic> json) {
    return ProfileModelClass(
      id: json['_id'],
      adminID: json['adminID'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatar: json['documents']['pic'],
      fatherName: json['fatherName'],
      mobileNo: json['mobile_no'],
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      religion: json['religion'],
      martialStatus: json['martial_status'],
      nationalId: json['national_id'],
      nationalIdNumber: json['national_id_number'],
      joiningDate: json['joining_date'],
      currentAddress: CurrentAddress.fromJson(json['current_address']),
      qualifications: (json['qualifications'] as List)
          .map((i) => Qualification.fromJson(i))
          .toList(),
      documents: Documents.fromJson(json['documents']),
      achievements: (json['achievements'] as List)
          .map((i) => Achievement.fromJson(i))
          .toList(),
      password: json['password'],
    );
  }
}

class CurrentAddress {
  String adminId;
  String category;
  int houseNo;
  String street;
  String city;
  String state;
  int postalCode;

  CurrentAddress({
    required this.adminId,
    required this.category,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  factory CurrentAddress.fromJson(Map<String, dynamic> json) {
    return CurrentAddress(
      adminId: json['admin_id'],
      category: json['category'] ?? '',
      houseNo: json['houseNo'] ?? 0,
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? 0,
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

class Qualification {
  String adminId;
  String qlfcName;
  int completionYear;

  Qualification({
    required this.adminId,
    required this.qlfcName,
    required this.completionYear,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      adminId: json['admin_id'],
      qlfcName: json['qlfc_name'],
      completionYear: json['completion_year'],
    );
  }
}

class Achievement {
  String name;
  String achmtsDesc;
  String digitalLink;

  Achievement({
    required this.name,
    required this.achmtsDesc,
    required this.digitalLink,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      name: json['name'],
      achmtsDesc: json['achmtsDesc'],
      digitalLink: json['digitalLink'],
    );
  }
}
