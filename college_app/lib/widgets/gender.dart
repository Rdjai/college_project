import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  const GenderPicker({super.key});

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  String _selectedGender = 'Gender';
  final List<String> _genders = [
    'Gender',
    'Male',
    'Female',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: _selectedGender,
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue!;
          });
        },
        items: _genders.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
}
