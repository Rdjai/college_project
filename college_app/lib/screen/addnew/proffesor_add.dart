// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, duplicate_ignore, use_key_in_widget_constructors, camel_case_types

import 'dart:convert';

import 'package:college_app/widgets/department_Data.dart';
import 'package:college_app/widgets/dob.dart';
import 'package:college_app/widgets/doc_upload_class.dart';
import 'package:college_app/widgets/gender.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class professoradd extends StatefulWidget {
  @override
  State<professoradd> createState() => _professoraddState();
}

TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController = TextEditingController();
TextEditingController _fathersNameController = TextEditingController();
TextEditingController _mathersNameController = TextEditingController();
TextEditingController _mobileNumberController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _religionController = TextEditingController();
TextEditingController _martialstatusController = TextEditingController();
TextEditingController _nationalidnumberController = TextEditingController();
TextEditingController _semesterController = TextEditingController();

TextEditingController _housenumberController = TextEditingController();
TextEditingController _streetController = TextEditingController();
TextEditingController _cityController = TextEditingController();
TextEditingController _stateController = TextEditingController();
TextEditingController _postalCodeController = TextEditingController();
TextEditingController _collegeController = TextEditingController();
TextEditingController _passingyearController = TextEditingController();
TextEditingController _medioumtypeController = TextEditingController();
TextEditingController _totalmarksController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _subjectController = TextEditingController();
TextEditingController _positionController = TextEditingController();
TextEditingController _saleryController = TextEditingController();
var teacherDepartment;
var pic;
var signatureImg;
var resume;
var bankDetails;
var genderValue;
var dateofbirth;

String nationalid = "Adhar Card";
String joiningDate = DateTime.now().toIso8601String();
String addCategory = "Permanent";

class _professoraddState extends State<professoradd> {
  Future addProfessor() async {
    final Map<String, dynamic> teacherData = {
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "fatherName": _fathersNameController.text,
      "mobile_no": _mobileNumberController.text,
      "email": _emailController.text,
      "gender": genderValue,
      "dob": dateofbirth,
      "religion": _religionController.text,
      "martial_status": "single",
      "national_id": "Adhar Card",
      "national_id_number": _nationalidnumberController.text,
      "departments": [
        {"name": teacherDepartment}
      ],
      "sem_and_subs": [
        {
          "semester": {"name": _semesterController.text},
          "subject": {"name": _subjectController.text}
        }
      ],
      "joining_date": joiningDate,
      "current_address": {
        "category": addCategory,
        "house_no": _housenumberController.text,
        "street": _streetController.text,
        "city": _cityController.text,
        "state": _stateController.text,
        "postal_code": _postalCodeController.text
      },
      "qualifications": [
        {
          "insitute_name": _collegeController.text,
          "qlfc_name": _medioumtypeController.text,
          "completion_year": _passingyearController.text
        }
      ],
      "documents": {
        "pic": pic,
        "signature_img": signatureImg,
        "resume_or_cv": resume,
        "bankDetails": bankDetails
      },
      "achievements": [
        {"name": "Null", "achmtsDesc": "Null", "digitalLink": "Null"}
      ],
      "salary": _saleryController.text,
      "password": _passwordController.text,
      "position": _positionController.text
    };

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin/add/professor'),
        body: jsonEncode(teacherData),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Profile created successfully'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context); // Navigate to the main page
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('College Management System notification'),
              content:
                  Text(responseBody['message'] ?? 'Error creating profile'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('College Management System notification'),
            content: Text('Failed to create profile: $e'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: screenWidth > 600 // Adjust this breakpoint as needed
            ? _buildDesktopForm()
            : _buildMobileForm(),
      ),
    );
  }

  Widget _buildDesktopForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Add New Professor",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 16.0,
          ),
          const Text('Personal Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(
                child: _buildTextField('First Name', 'Enter your first name',
                    _firstNameController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField(
                    'Last Name', 'Enter your first name', _lastNameController),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Father\'s Name',
                    'Enter your father\'s name', _fathersNameController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField('Phone Number',
                    'Enter your phone number', _mobileNumberController),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                    'Email', 'Enter your email', _emailController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField('Adhar number', 'Enter Adhar number',
                    _nationalidnumberController),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GenderPicker(
                onchanged: ((p0) {
                  setState(() {
                    genderValue = p0;
                  });
                }),
              ),
              DobPicker(
                  onDateSelected: (data) {
                    setState(() {
                      dateofbirth = data.toIso8601String();
                    });
                  },
                  text: 'Date of birth'),
            ],
          ),
          const Text('Select Department ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(child: DepartmentData(
                onChanged: (p0) {
                  setState(() {
                    teacherDepartment = p0;
                  });
                },
              )),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField(
                    'semester ', 'Enter semester', _semesterController),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                    'Subject ', 'Enter Subject', _subjectController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField(
                    'Position', 'Enter Position', _positionController),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          // "joining_date": "2020-01-01",
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Address Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('House Number',
                        'Enter your House Number', _housenumberController),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: _buildTextField('Street name',
                        'Enter your Street name', _streetController),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        'City name', 'Enter your City name', _cityController),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: _buildTextField('State Names',
                        'Enter your State Names', _stateController),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('Postal code',
                        'Enter your Postal code', _postalCodeController),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: _buildTextField(
                        'religion', 'Enter your religion', _religionController),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Qualifications & education details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('insitute name',
                        'Enter insitute name', _collegeController),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: _buildTextField('Passing Year',
                        'Enter your passing year', _passingyearController),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('Degree and higher details',
                        'Enter your Degree details', _medioumtypeController),
                  ),
                ],
              ),
            ],
          ),
          const Text('Password & salery',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                    'Enter Password', 'Enter Password', _passwordController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField(
                    'Enter Salery', 'Enter Salery', _saleryController),
              ),
            ],
          ),

          const SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("upload documents",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                  onPressed: () {
                    var screenWidth = MediaQuery.of(context).size.width;
                    showModalBottomSheet(
                      constraints:
                          BoxConstraints.tight(Size.fromWidth(screenWidth)),
                      backgroundColor: Colors.black.withOpacity(0.3),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              UploadDocsWidget(
                                text: "Upload profile Image",
                                iconName: Icons.photo_library,
                                onIconSelected: (p0) {
                                  setState(() {
                                    pic = p0.toString();
                                  });
                                },
                              ),
                              UploadDocsWidget(
                                text: "Upload Signature Image",
                                iconName: Icons.photo_library,
                                onIconSelected: (p0) {
                                  setState(() {
                                    signatureImg = p0.toString();
                                  });
                                },
                              ),
                              UploadDocsWidget(
                                text: "Upload Resume Image",
                                iconName: Icons.assignment_add,
                                onIconSelected: (p0) {
                                  setState(() {
                                    resume = p0.toString();
                                  });
                                },
                              ),
                              UploadDocsWidget(
                                text: "Bank Passbook photos",
                                iconName: Icons.account_balance,
                                onIconSelected: (p0) {
                                  setState(() {
                                    bankDetails = p0.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("upload documents")),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
              style: const ButtonStyle(alignment: Alignment.center),
              onPressed: () {
                addProfessor();
              },
              child: const Text("Add Professor")),
          const SizedBox(
            height: 90,
          )
        ],
      ),
    );
  }

  Widget _buildMobileForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Personal Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTextField(
              'First Name', 'Enter your first name', _firstNameController),
          _buildTextField(
              'Last Name', 'Enter your last name', _lastNameController),
          _buildTextField('Father\'s Name', 'Enter your father\'s name',
              _fathersNameController),
          _buildTextField('Mother\'s Name', 'Enter your mother\'s name',
              _mathersNameController),
          _buildTextField('Phone Number', 'Enter your phone number',
              _mobileNumberController),
          _buildTextField('Email', 'Enter your email', _emailController),
          _buildGenderDropdown(),
          DobPicker(onDateSelected: (data) {}, text: 'Date of birth'),
          _buildTextField(
              'Religion', 'Enter your religion', _religionController),
          _buildTextField('Marital Status', 'Enter your marital status',
              _martialstatusController),
          _buildTextField('National ID', 'Enter your national ID',
              _nationalidnumberController),
          _buildTextField('National ID Number', 'Enter your national ID number',
              _nationalidnumberController),
          _buildTextField(
              'Admission Date', 'Enter admission date', _postalCodeController),
          const SizedBox(height: 24),
          const Text('Present Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTextField('State', 'Enter your state', _stateController),
          _buildTextField(
              'District/City', 'Enter your district/city', _stateController),
          _buildTextField(
              'postel code', 'Enter your postel code', _postalCodeController),
          const SizedBox(height: 24),
          const Text('Educational Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTextField(
              'School Name', 'Enter your school name', _collegeController),
          _buildTextField('Passing Year', 'Enter your passing year',
              _passingyearController),
          _buildTextField(
              'Total Number', 'Enter your total number', _totalmarksController),
          const SizedBox(height: 24),
          const Text('Academic Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const SizedBox(height: 24),
          const Text('Documents',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Handle form submission
            },
            child: const Text('Submit'),
          ),
        ],
      ),
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

  Widget _buildGenderDropdown() {
    String _selectedGender = 'Gender';
    final List<String> _genders = [
      'Gender',
      'Male',
      'Female',
      'Other',
    ];
    return DropdownButton<String>(
      value: _selectedGender,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedGender = newValue;
          });
        }
      },
      items: _genders.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
