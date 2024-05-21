import 'package:college_app/widgets/dob.dart';
import 'package:college_app/widgets/gender.dart';
import 'package:flutter/material.dart';

class ResponsiveForm extends StatefulWidget {
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

class _ResponsiveFormState extends State<ResponsiveForm> {
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
    String _selectedGender = 'Gender';
    final List<String> _genders = [
      'Gender',
      'Male',
      'Female',
      'Other',
    ];
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
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
                  debugPrint(p0);
                }),
              ),
              DobPicker(
                  onDateSelected: (data) {
                    print(data);
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
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: _buildTextField('State Names',
                        'Enter your State Names', _stateController),
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
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("upload documents",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                  onPressed: () {}, child: const Text("upload documents"))
            ],
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
          // _buildTextField('First Name', 'Enter your first name'),
          // _buildTextField('Last Name', 'Enter your last name'),
          // _buildTextField('Father\'s Name', 'Enter your father\'s name'),
          // _buildTextField('Mother\'s Name', 'Enter your mother\'s name'),
          // _buildTextField('Phone Number', 'Enter your phone number'),
          // _buildTextField('Email', 'Enter your email'),
          // // _buildGenderDropdown(),
          // // _buildDateOfBirthPicker(),
          // _buildTextField('Religion', 'Enter your religion'),
          // _buildTextField('Marital Status', 'Enter your marital status'),
          // _buildTextField('Blood Group', 'Enter your blood group'),
          // _buildTextField('National ID', 'Enter your national ID'),
          // _buildTextField(
          //     'National ID Number', 'Enter your national ID number'),
          // _buildTextField('Admission Date', 'Enter admission date'),
          // const SizedBox(height: 24),
          // const Text('Present Address',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // const SizedBox(height: 16),
          // _buildTextField('State', 'Enter your state'),
          // _buildTextField('District/City', 'Enter your district/city'),
          // _buildTextField('Address', 'Enter your address'),
          // const SizedBox(height: 24),
          // const Text('Educational Information',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // const SizedBox(height: 16),
          // _buildTextField('School Name', 'Enter your school name'),
          // _buildTextField('Passing Year', 'Enter your passing year'),
          // _buildTextField('Total Number', 'Enter your total number'),
          // const SizedBox(height: 24),
          // const Text('Academic Information',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // const SizedBox(height: 16),
          // _buildTextField('Program', 'Enter your program'),
          // _buildTextField('Batch', 'Enter your batch'),
          // _buildTextField('Session', 'Enter your session'),
          // _buildTextField('Semester', 'Enter your semester'),
          // const SizedBox(height: 24),
          // const Text('Documents',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // const SizedBox(height: 16),
          // _buildTextField('Photo', 'Upload your photo'),
          // _buildTextField('Signature', 'Upload your signature'),
          // _buildTextField('Marksheet 10th', 'Upload your 10th marksheet'),
          // _buildTextField('Marksheet 12th', 'Upload your 12th marksheet'),
          // _buildTextField(
          //     'Bachelor Marksheet', 'Upload your bachelor marksheet'),
          // const SizedBox(height: 24),
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
