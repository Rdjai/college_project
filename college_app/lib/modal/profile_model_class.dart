class Address {
  final String category;
  final int houseNo;
  final String street;
  final String city;
  final String state;
  final int postalCode;

  Address({
    required this.category,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  Map<String, dynamic> toJson() => {
        'category': category,
        'house_no': houseNo,
        'street': street,
        'city': city,
        'state': state,
        'postal_code': postalCode,
      };
}

class Qualification {
  final String instituteName;
  final String qlfcName;
  final String completionYear;

  Qualification({
    required this.instituteName,
    required this.qlfcName,
    required this.completionYear,
  });

  Map<String, dynamic> toJson() => {
        'insitute_name': instituteName,
        'qlfc_name': qlfcName,
        'completion_year': completionYear,
      };
}

class Documents {
  final String pic;
  final String signatureImg;
  final String resumeOrCv;
  final String bankDetails;

  Documents({
    required this.pic,
    required this.signatureImg,
    required this.resumeOrCv,
    required this.bankDetails,
  });

  Map<String, dynamic> toJson() => {
        'pic': pic,
        'signature_img': signatureImg,
        'resume_or_cv': resumeOrCv,
        'bankDetails': bankDetails,
      };
}

class User {
  final String firstName;
  final String lastName;
  final String avatar;
  final String fatherName;
  final int mobileNo;
  final String email;
  final String gender;
  final String dob;
  final String religion;
  final String martialStatus;
  final String nationalId;
  final int nationalIdNumber;
  final String joiningDate;
  final Address currentAddress;
  final List<Qualification> qualifications;
  final Documents documents;
  final List<dynamic> achievements;
  final String password;

  User({
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

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'avatar': avatar,
        'fatherName': fatherName,
        'mobile_no': mobileNo,
        'email': email,
        'gender': gender,
        'dob': dob,
        'religion': religion,
        'martial_status': martialStatus,
        'national_id': nationalId,
        'national_id_number': nationalIdNumber,
        'joining_date': joiningDate,
        'current_address': currentAddress.toJson(),
        'qualifications': qualifications.map((q) => q.toJson()).toList(),
        'documents': documents.toJson(),
        'achievements': achievements,
        'password': password,
      };
}
