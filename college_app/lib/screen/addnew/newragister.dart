// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';

import 'package:college_app/screen/addnew/proffesor_add.dart';
import 'package:college_app/widgets/department_Data.dart';
import 'package:college_app/widgets/dob.dart';
import 'package:college_app/widgets/doc_upload_class.dart';
import 'package:college_app/widgets/gender.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResponsiveForm extends StatefulWidget {
  const ResponsiveForm({super.key});

  @override
  State<ResponsiveForm> createState() => _ResponsiveFormState();
}

TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController = TextEditingController();
TextEditingController _fathersNameController = TextEditingController();
TextEditingController _mathersNameController = TextEditingController();
TextEditingController _mobileNumberController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _religionController = TextEditingController();
TextEditingController _martialstatusController = TextEditingController();
TextEditingController _bloodgroupController = TextEditingController();
TextEditingController _nationalidnumberController = TextEditingController();
TextEditingController _housenumberController = TextEditingController();
TextEditingController _streetController = TextEditingController();
TextEditingController _cityController = TextEditingController();
TextEditingController _stateController = TextEditingController();
TextEditingController _postalCodeController = TextEditingController();
TextEditingController _collegeController = TextEditingController();
TextEditingController _passingyearController = TextEditingController();
TextEditingController _medioumtypeController = TextEditingController();
TextEditingController _totalmarksController = TextEditingController();
TextEditingController _enrollmentnoController = TextEditingController();
TextEditingController _departmentController = TextEditingController();
TextEditingController _semisterController = TextEditingController();
TextEditingController _semisterResultController = TextEditingController();
TextEditingController _semisterResultLinkController = TextEditingController();
TextEditingController _semisterFeeController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _currentPaidFeesController = TextEditingController();

var pic;
var singImg;
var marksheet_10th;
var marksheet_12th;
var marksheet_Graduation;
var selectedCourse;
String _selectedGender = 'Gender';
String dob = "male";

class _ResponsiveFormState extends State<ResponsiveForm> {
  Future addStudent() async {
    final Map<String, dynamic> studentEntry = {
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "fatherName": _fathersNameController.text,
      "motherName": _mathersNameController.text,
      "mobile_no": _mobileNumberController.text,
      "email": _emailController.text,
      "gender": _selectedGender,
      "dob": dob,
      "religion": _religionController.text,
      "martial_status": "single",
      "blood_group": _bloodgroupController.text,
      "national_id": "Adhar Card",
      "national_id_number": _nationalidnumberController.text,
      "addmission_date": DateTime.now().toIso8601String(),
      "current_address": {
        "category": "student",
        "house_no": _housenumberController.text,
        "street": _streetController.text,
        "city": _cityController.text,
        "state": _stateController.text,
        "postal_code": _postalCodeController.text
      },
      "education": [
        {
          "school_or_college": _collegeController.text,
          "passing_year": _passingyearController.text,
          "medium": _medioumtypeController.text,
          "total_marks": _totalmarksController.text
        }
      ],
      "enrollment_no": _enrollmentnoController.text,
      "documents": {
        "pic": pic,
        "signature_img": singImg,
        "marksheet_10th": marksheet_10th,
        "marksheet_12th": marksheet_12th,
        "bachelor_marksheet": marksheet_Graduation
      },
      "department": {
        "name": selectedCourse,
      },
      "results": [
        {"semester": "1", "resultLink": ""}
      ],
      "achievements": [
        {"name": "null", "achieveDesc": "null", "digitalLink": "null"}
      ],
      "fees": [
        {
          "semester": {"name": "1"},
          "fee": {
            "total_fee": _semisterFeeController.text,
            "due_fee": 0,
            "submitted_fee": _currentPaidFeesController.text
          }
        }
      ],
      "semester": {
        "semester": "1",
        "events": [
          {
            "evnt_name": "Null",
          }
        ]
      },
      "password": _passwordController.text
    };
    print("Teacher Data: $studentEntry");

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin/add/student'),
        body: jsonEncode(studentEntry),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
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
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } else {
        print(response.body);
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
      print(e.toString());
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDesktopForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60.0,
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
                child: _buildTextField('Mother\'s Name',
                    'Enter your mother\'s name', _mathersNameController),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Phone Number',
                    'Enter your phone number', _mobileNumberController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField(
                    'Email', 'Enter your email', _emailController),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GenderPicker(
                onchanged: ((p0) {
                  _selectedGender = p0;
                }),
              ),
              DobPicker(
                  onDateSelected: (data) {
                    dob = data.toIso8601String();
                  },
                  text: 'Date of birth'),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                    'Religion', 'Enter your religion', _religionController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField('Marital Status',
                    'Enter your marital status', _martialstatusController),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Blood Group', 'Enter your blood group',
                    _bloodgroupController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField('Adhar Number',
                    'Enter your Adhar Number', _nationalidnumberController),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
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
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('enter previous year education details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('School or college name',
                        'Enter School or college name', _collegeController),
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
                    child: _buildTextField(
                        'School or college medium type',
                        'Enter School or college edium type',
                        _medioumtypeController),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: _buildTextField('total marks',
                        'Enter your total marks', _totalmarksController),
                  ),
                ],
              ),
            ],
          ),
          const Text('enrollment number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            child: _buildTextField('enrollment number',
                'Enter your enrollment number', _enrollmentnoController),
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
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      singImg = p0.toString();
                                    });
                                  },
                                ),
                                UploadDocsWidget(
                                  text: "Upload 10th Marksheet Image",
                                  iconName: Icons.assignment_add,
                                  onIconSelected: (p0) {
                                    setState(() {
                                      marksheet_10th = p0.toString();
                                    });
                                  },
                                ),
                                UploadDocsWidget(
                                  text: " Previus 12th marksheet",
                                  iconName: Icons.account_balance,
                                  onIconSelected: (p0) {
                                    setState(() {
                                      marksheet_12th = p0.toString();
                                    });
                                  },
                                ),
                                UploadDocsWidget(
                                  text: "Gratuation",
                                  iconName: Icons.account_balance,
                                  onIconSelected: (p0) {
                                    setState(() {
                                      marksheet_Graduation = p0.toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("upload documents")),
            ],
          ),
          DepartmentData(
            onChanged: (p0) {
              selectedCourse = p0;
            },
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField('Semister result', 'Semister result',
                    _semisterResultController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField('Semister result Link',
                    'Semister result Link', _semisterResultLinkController),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                    'Current semister', 'Semister', _semisterController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField(
                    'course fee', 'enter course fee', _semisterFeeController),
              ),
            ],
          ),
          const Text('Enter Student Login Password',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(
                child: _buildTextField('current Paid fee', 'current Paid fee',
                    _currentPaidFeesController),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: _buildTextField('Student Login Password',
                    'Enter Student Login Password', _passwordController),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
              onPressed: () {
                addStudent();
              },
              child: const Text("create student profile")),
          const SizedBox(
            height: 100.0,
          ),
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
          DobPicker(
              onDateSelected: (data) {
                print(data);
              },
              text: 'Date of birth'),
          _buildTextField(
              'Religion', 'Enter your religion', _religionController),
          _buildTextField('Marital Status', 'Enter your marital status',
              _martialstatusController),
          _buildTextField(
              'Blood Group', 'Enter your blood group', _bloodgroupController),
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
