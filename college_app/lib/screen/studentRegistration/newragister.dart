import 'package:college_app/widgets/dob.dart';
import 'package:college_app/widgets/gender.dart';
import 'package:flutter/material.dart';

class ResponsiveForm extends StatefulWidget {
  @override
  State<ResponsiveForm> createState() => _ResponsiveFormState();
}

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Personal Information',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildTextField('First Name', 'Enter your first name'),
                _buildTextField('Last Name', 'Enter your last name'),
                _buildTextField('Father\'s Name', 'Enter your father\'s name'),
                _buildTextField('Mother\'s Name', 'Enter your mother\'s name'),
                _buildTextField('Phone Number', 'Enter your phone number'),
                _buildTextField('Email', 'Enter your email'),
                GenderPicker(),
                DobPicker(
                    onDateSelected: (data) {
                      print(data);
                    },
                    text: 'Date of birth'),
                _buildTextField('Religion', 'Enter your religion'),
                _buildTextField('Marital Status', 'Enter your marital status'),
                _buildTextField('Blood Group', 'Enter your blood group'),
                _buildTextField('National ID', 'Enter your national ID'),
                _buildTextField(
                    'National ID Number', 'Enter your national ID number'),
                _buildTextField('Admission Date', 'Enter admission date'),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Present Address',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildTextField('State', 'Enter your state'),
                _buildTextField('District/City', 'Enter your district/city'),
                _buildTextField('Address', 'Enter your address'),
                const SizedBox(height: 24),
                const Text('Educational Information',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildTextField('School Name', 'Enter your school name'),
                _buildTextField('Passing Year', 'Enter your passing year'),
                _buildTextField('Total Number', 'Enter your total number'),
                const SizedBox(height: 24),
                const Text('Academic Information',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildTextField('Program', 'Enter your program'),
                _buildTextField('Batch', 'Enter your batch'),
                _buildTextField('Session', 'Enter your session'),
                _buildTextField('Semester', 'Enter your semester'),
                const SizedBox(height: 24),
                const Text('Documents',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildTextField('Photo', 'Upload your photo'),
                _buildTextField('Signature', 'Upload your signature'),
                _buildTextField('Marksheet 10th', 'Upload your 10th marksheet'),
                _buildTextField('Marksheet 12th', 'Upload your 12th marksheet'),
                _buildTextField(
                    'Bachelor Marksheet', 'Upload your bachelor marksheet'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
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
          _buildTextField('First Name', 'Enter your first name'),
          _buildTextField('Last Name', 'Enter your last name'),
          _buildTextField('Father\'s Name', 'Enter your father\'s name'),
          _buildTextField('Mother\'s Name', 'Enter your mother\'s name'),
          _buildTextField('Phone Number', 'Enter your phone number'),
          _buildTextField('Email', 'Enter your email'),
          // _buildGenderDropdown(),
          // _buildDateOfBirthPicker(),
          _buildTextField('Religion', 'Enter your religion'),
          _buildTextField('Marital Status', 'Enter your marital status'),
          _buildTextField('Blood Group', 'Enter your blood group'),
          _buildTextField('National ID', 'Enter your national ID'),
          _buildTextField(
              'National ID Number', 'Enter your national ID number'),
          _buildTextField('Admission Date', 'Enter admission date'),
          const SizedBox(height: 24),
          const Text('Present Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTextField('State', 'Enter your state'),
          _buildTextField('District/City', 'Enter your district/city'),
          _buildTextField('Address', 'Enter your address'),
          const SizedBox(height: 24),
          const Text('Educational Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTextField('School Name', 'Enter your school name'),
          _buildTextField('Passing Year', 'Enter your passing year'),
          _buildTextField('Total Number', 'Enter your total number'),
          const SizedBox(height: 24),
          const Text('Academic Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTextField('Program', 'Enter your program'),
          _buildTextField('Batch', 'Enter your batch'),
          _buildTextField('Session', 'Enter your session'),
          _buildTextField('Semester', 'Enter your semester'),
          const SizedBox(height: 24),
          const Text('Documents',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTextField('Photo', 'Upload your photo'),
          _buildTextField('Signature', 'Upload your signature'),
          _buildTextField('Marksheet 10th', 'Upload your 10th marksheet'),
          _buildTextField('Marksheet 12th', 'Upload your 12th marksheet'),
          _buildTextField(
              'Bachelor Marksheet', 'Upload your bachelor marksheet'),
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

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: TextFormField(
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
