class ProfileModelClass {
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
  List<dynamic> achievements;
  String password;

  ProfileModelClass({
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
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatar: json['avatar'],
      fatherName: json['fatherName'],
      mobileNo: json['mobileNo'],
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      religion: json['religion'],
      martialStatus: json['martialStatus'],
      nationalId: json['nationalId'],
      nationalIdNumber: json['nationalIdNumber'],
      joiningDate: json['joiningDate'],
      currentAddress: CurrentAddress.fromJson(json['currentAddress']),
      qualifications: (json['qualifications'] as List)
          .map((i) => Qualification.fromJson(i))
          .toList(),
      documents: Documents.fromJson(json['documents']),
      achievements: json['achievements'],
      password: json['password'],
    );
  }
}

class CurrentAddress {
  String category;
  int houseNo;
  String street;
  String city;
  String state;
  int postalCode;

  CurrentAddress({
    required this.category,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  factory CurrentAddress.fromJson(Map<String, dynamic> json) {
    return CurrentAddress(
      category: json['category'],
      houseNo: json['houseNo'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
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
      signatureImg: json['signatureImg'],
      resumeOrCv: json['resumeOrCv'],
      bankDetails: json['bankDetails'],
    );
  }
}

class Qualification {
  String insituteName;
  String qlfcName;
  String completionYear;

  Qualification({
    required this.insituteName,
    required this.qlfcName,
    required this.completionYear,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      insituteName: json['insituteName'],
      qlfcName: json['qlfcName'],
      completionYear: json['completionYear'],
    );
  }
}
