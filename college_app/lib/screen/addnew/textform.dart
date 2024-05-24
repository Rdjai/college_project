import 'package:college_app/widgets/dob.dart';
import 'package:college_app/widgets/textfield.dart';
import 'package:flutter/material.dart';

class FirstForm extends StatefulWidget {
  @override
  State<FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> {
  String _selectedGender = 'Gender';
  final List<String> _genders = [
    'Gender',
    'Male',
    'Female',
    'Other',
  ];
  String _selectReligion = 'Hindu';
  final List<String> _religion = [
    'Hindu',
    'Muslim',
    'Buddha',
    'Christian',
  ];
  String maritalStatus = 'maritalStatus';
  final List<String> _maritalStatus = ['Marital status', 'Single', 'Married'];
  String _nationalId = 'Adhar card';
  final List<String> nationalId = [
    'Adhar card',
    'pan card',
    'Driving Licence',
    'voter card',
  ];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fsController = TextEditingController();
  final TextEditingController _lsController = TextEditingController();
  final TextEditingController _fatherName = TextEditingController();
  final TextEditingController _motherName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: InputArea(
                        lebelText: 'Fist Name',
                        controller: _fsController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Fist Name';
                          }
                          return null;
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InputArea(
                        lebelText: 'Last Name',
                        controller: _lsController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Last Name';
                          }
                          return null;
                        },
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InputArea(
                        lebelText: 'Father Name',
                        controller: _fatherName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Father Name';
                          }
                          return null;
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InputArea(
                        lebelText: 'Mother Name',
                        controller: _motherName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Mother Name';
                          }
                          return null;
                        },
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InputArea(
                        lebelText: 'Email',
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: InputArea(
                        lebelText: 'Phone Number',
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Phone';
                          }
                          return null;
                        },
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                            value: _selectedGender,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGender = newValue!;
                              });
                            },
                            items: _genders
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DobPicker(
                          text: 'Date of birth',
                          onDateSelected: (date) {
                            // Handle selected date here (e.g., print it)
                            print(date);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                            value: _selectReligion,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectReligion = newValue!;
                              });
                            },
                            items: _religion
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                            value: maritalStatus,
                            onChanged: (String? newValue) {
                              setState(() {
                                maritalStatus = newValue!;
                              });
                            },
                            items: _maritalStatus
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                            value: _nationalId,
                            onChanged: (String? newValue) {
                              setState(() {
                                _nationalId = newValue!;
                              });
                            },
                            items: nationalId
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: TextField()),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Admission Date")),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DobPicker(
                          text: 'Admission Date',
                          onDateSelected: (date) {
                            // Handle selected date here (e.g., print it)
                            print(date);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Previus")),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitForm();
                            }
                          },
                          child: const Text("Next"))
                    ],
                  ),
                ],
              )),
        ));
  }

  void _submitForm() {
    // Form data submission logic here
    // String name = _nameController.text;s
    String email = _emailController.text;

    // Print or process the form data as needed
    print('Name: l, Email: $email');
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    // _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
