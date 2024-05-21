import 'dart:convert';
import 'dart:io';

import 'package:college_app/screen/login.dart';
import 'package:college_app/screen/pages/home.dart';
import 'package:college_app/screen/signup.dart';
import 'package:college_app/widgets/dob.dart';
import 'package:college_app/widgets/doc_upload_class.dart';
import 'package:college_app/widgets/gender.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DsizeSignup extends StatefulWidget {
  const DsizeSignup({Key? key}) : super(key: key);

  @override
  State<DsizeSignup> createState() => _DsizeSignupState();
}

class _DsizeSignupState extends State<DsizeSignup> {
  File? pickImgPath;
  String? avatar;
  String? singImg;
  String? resumeImg;
  String? passbookImg;

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _nationalIdNumberController =
      TextEditingController();
  final TextEditingController _martialStatusController =
      TextEditingController();
  final TextEditingController _currentAddressHouseNoController =
      TextEditingController();
  final TextEditingController _currentAddressStreetController =
      TextEditingController();
  final TextEditingController _currentAddressCityController =
      TextEditingController();
  final TextEditingController _currentAddressStateController =
      TextEditingController();
  final TextEditingController _currentAddressPostalCodeController =
      TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  final TextEditingController _achievementController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _gender = '';
  String dob = '';
  DateTime joining = DateTime.now();

  Future<void> _imagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickImgPath = File(image.path);
      });
    }
  }

  Future<void> _uploadImg(File imageFile, BuildContext context) async {
    if (imageFile == null) return;

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    String imagePath = '/foldername/$fileName.jpg';

    firebase_storage.Reference ref = storage.ref(imagePath);
    firebase_storage.UploadTask uploadTask = ref.putFile(
      imageFile,
      firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
    );

    try {
      await uploadTask.whenComplete(() async {
        String? imgUri = await ref.getDownloadURL();
        print("Uploaded image URL: $imgUri");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully!')),
        );
        // avatar = imgUri;
        setState(() {
          avatar = imgUri;
        });
      });
    } catch (error) {
      print("Error uploading image: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $error')),
      );
    }
  }

  Future createProfile(BuildContext context) async {
    final Map<String, dynamic> profileData = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'avatar': avatar,
      'fatherName': _fatherNameController.text,
      'mobile_no': _mobileNoController.text,
      'email': _emailController.text,
      'gender': _gender,
      'dob': dob,
      'religion': _religionController.text,
      'martial_status': _martialStatusController.text,
      'national_id': "Adhar Card",
      'national_id_number': _nationalIdNumberController.text,
      'joining_date': joining.toIso8601String(),
      'current_address': {
        "category": "admin",
        'house_no': _currentAddressHouseNoController.text,
        'street': _currentAddressStreetController.text,
        'city': _currentAddressCityController.text,
        'state': _currentAddressStateController.text,
        'postal_code': _currentAddressPostalCodeController.text,
      },
      'qualifications': [
        {
          'institute_name': 'Dr. Bhiraom Adbekar unie, agra',
          'qlfc_name': _qualificationController.text,
          'completion_year': 2010,
        },
      ],
      'documents': {
        'pic': avatar,
        'signature_img': singImg,
        'resume_or_cv': resumeImg,
        'bankDetails': passbookImg,
      },
      'achievements': [
        {
          'name': _achievementController.text,
          'achmtsDesc': "Blank",
          'digitalLink': "_achievementLinkController.text",
        },
      ],
      'password': _passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin/create/profile'),
        body: jsonEncode(profileData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
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
                    Navigator.pop(context); // Navigate to the main page
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
              title: const Text('Error'),
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
            title: const Text('Error'),
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
    return Material(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/accountant.json',
                    width: 250.0,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.619),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Use min MainAxisSize
                        children: [
                          const Text(
                            "create Account Now",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Fill the Account details",
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 20.0),
                          pickImgPath != null
                              ? Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundImage: FileImage(pickImgPath!),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _uploadImg(pickImgPath!, context);
                                          },
                                          child: const Text('upload Image'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _imagePicker();
                                          },
                                          child: const Text('change Image'),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                      ),
                                      child: const Icon(Icons.person,
                                          size: 60, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        _imagePicker();
                                      },
                                      child: const Text('Select Image'),
                                    ),
                                  ],
                                ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _firstNameController,
                                  decoration: const InputDecoration(
                                    hintText: "First Name",
                                    label: Text("First Name"),
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _lastNameController,
                                  decoration: const InputDecoration(
                                    hintText: "last name",
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _fatherNameController,
                                  decoration: const InputDecoration(
                                    hintText: "father name",
                                    prefixIcon: Icon(Icons.escalator_warning),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _mobileNoController,
                                  decoration: const InputDecoration(
                                    hintText: "mobile number",
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: "xyz@email.com",
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Selected gender",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      GenderPicker(
                                        onchanged: (gender) {
                                          setState(() {
                                            _gender = gender.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 200,
                              ),
                              Expanded(
                                child: DobPicker(
                                    onDateSelected: (p0) {
                                      setState(() {
                                        dob = p0.toIso8601String();
                                      });
                                    },
                                    text: "Date of bearth"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _religionController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Religion",
                                    prefixIcon: Icon(Icons.temple_hindu),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _martialStatusController,
                                  decoration: const InputDecoration(
                                    hintText: "martial status/ NA/Yes",
                                    prefixIcon: Icon(Icons.badge),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            controller: _nationalIdNumberController,
                            decoration: const InputDecoration(
                              hintText: "Adhar number",
                              prefixIcon: Icon(Icons.badge),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _currentAddressHouseNoController,
                                  decoration: const InputDecoration(
                                    hintText: "House number",
                                    prefixIcon: Icon(Icons.looks_one),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _currentAddressStreetController,
                                  decoration: const InputDecoration(
                                    hintText: "Street",
                                    prefixIcon: Icon(Icons.streetview),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _currentAddressCityController,
                                  decoration: const InputDecoration(
                                    hintText: "city",
                                    prefixIcon: Icon(Icons.location_city),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _currentAddressStateController,
                                  decoration: const InputDecoration(
                                    hintText: "State",
                                    prefixIcon: Icon(Icons.location_history),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller:
                                      _currentAddressPostalCodeController,
                                  decoration: const InputDecoration(
                                    hintText: "postel code",
                                    prefixIcon: Icon(Icons.local_shipping),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _qualificationController,
                                  decoration: const InputDecoration(
                                    hintText: "Qualification",
                                    prefixIcon: Icon(Icons.school),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.description),
                                  const Text("Upload Document"),
                                  ElevatedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.3),
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  UploadDocsWidget(
                                                    text:
                                                        "Upload Signature Image",
                                                    iconName:
                                                        Icons.photo_library,
                                                    onIconSelected: (p0) {
                                                      setState(() {
                                                        singImg = p0.toString();
                                                      });
                                                    },
                                                  ),
                                                  UploadDocsWidget(
                                                    text: "Upload Resume Image",
                                                    iconName:
                                                        Icons.assignment_add,
                                                    onIconSelected: (p0) {
                                                      setState(() {
                                                        resumeImg =
                                                            p0.toString();
                                                      });
                                                    },
                                                  ),
                                                  UploadDocsWidget(
                                                    text:
                                                        "Bank Passbook photos",
                                                    iconName:
                                                        Icons.account_balance,
                                                    onIconSelected: (p0) {
                                                      setState(() {
                                                        passbookImg =
                                                            p0.toString();
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      "Upload",
                                    ),
                                  ),
                                ],
                              )

                                  // TextField(
                                  //   controller: _documentController,
                                  //   decoration: const InputDecoration(
                                  //     hintText: "documents",
                                  //     prefixIcon: Icon(Icons.school),
                                  //   ),
                                  // ),
                                  ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _achievementController,
                                  decoration: const InputDecoration(
                                    hintText: "achievements",
                                    prefixIcon: Icon(Icons.school),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const SizedBox(height: 10.0),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: "Enter Your Password",
                              prefixIcon: Icon(Icons.school),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                createProfile(context);
                              },
                              child: const Text("Create profile"),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: const Text(
                                "I have an account login",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
