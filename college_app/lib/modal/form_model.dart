class FormData {
  String selectedGender;

  FormData({required this.selectedGender});

  Map<String, dynamic> toJson() {
    return {
      'selectedGender': selectedGender,
    };
  }

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      selectedGender: json['selectedGender'],
    );
  }
}
