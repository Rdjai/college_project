class StudentModel {
  final int id;
  final String name;
  final String email;
  final String avatar;

  StudentModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.avatar});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        id: json['id'],
        name: json['first_name'] + ' ' + json['last_name'],
        email: json['email'],
        avatar: json['avatar']);
  }
}
