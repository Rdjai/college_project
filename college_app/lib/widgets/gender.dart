import 'package:college_app/modal/form_model.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  final void Function(String) onchanged;
  const GenderPicker({super.key, required this.onchanged});
  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  String _selectedGender = 'prefer not to say';
  final List<String> _genders = [
    "male",
    "female",
    "other",
    "prefer not to say"
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: _selectedGender,
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue!;
          });
          widget.onchanged(_selectedGender);
        },
        onTap: () {
          FormData formData = FormData(selectedGender: _selectedGender);
          String jsonData = formData.toJson().toString();
        },
        items: _genders.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
}
