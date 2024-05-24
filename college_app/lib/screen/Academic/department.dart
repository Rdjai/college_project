import 'package:flutter/material.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

TextEditingController _departmentController = TextEditingController();
TextEditingController _semisterController = TextEditingController();

class _DepartmentScreenState extends State<DepartmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_createSemister()],
    );
  }

  Widget _Department() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Add "),
          Expanded(
            child: _buildTextField(
                'total marks', 'Enter your total marks', _departmentController),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Create department"))
        ],
      ),
    );
  }

  Widget _createSemister() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          child: Column(
        children: [
          SizedBox(
            height: 16.0,
          ),
          _buildTextField("Semister", "Enter Semister", _semisterController)
        ],
      )),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController textControl) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: textControl,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
