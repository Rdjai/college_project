import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepartmentData extends StatefulWidget {
  final void Function(String) onChanged;
  const DepartmentData({Key? key, required this.onChanged}) : super(key: key);

  @override
  _DepartmentDataState createState() => _DepartmentDataState();
}

class _DepartmentDataState extends State<DepartmentData> {
  String? _selectedDepartment;
  List<dynamic>? _departments;
  bool _isLoading = true;

  Future<void> fetchDepartments() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://localhost:3000/api/v1/departments/get/all_departments"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _departments =
              responseData['departments']; // Extract departments array
          _isLoading = false;
        });
      } else {
        print(
            'Failed to load departments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : DropdownButton<String>(
            value: _selectedDepartment,
            onChanged: (newValue) {
              setState(() {
                _selectedDepartment = newValue;
              });
              widget.onChanged(_selectedDepartment!);
            },
            items: _departments?.map<DropdownMenuItem<String>>((department) {
                  return DropdownMenuItem<String>(
                    value: department['_id'],
                    child: Text(department['name']),
                  );
                }).toList() ??
                [],
          );
  }
}
