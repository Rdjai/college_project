// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, avoid_print

import 'dart:convert';
import 'package:college_app/screen/pages/home.dart';
import 'package:college_app/screen/ragister.dart';
import 'package:college_app/screen/varify_otp.dart';
import 'package:college_app/student/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentLoginPage extends StatefulWidget {
  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkTokenExpiry();
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt(
        'token_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> checkTokenExpiry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? timestamp = prefs.getInt('token_timestamp');

    if (token != null && timestamp != null) {
      final DateTime savedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final DateTime currentTime = DateTime.now();

      if (currentTime.difference(savedTime).inHours >= 24) {
        // Token is expired
        await prefs.remove('token');
        await prefs.remove('token_timestamp');
        print("Token has expired and has been removed.");
      } else {
        print("Token is still valid.");
      }
    } else {
      print("No token found.");
    }
  }

  Future<void> loginAccount(
      String email, String pass, BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print("Form is not valid");
      return;
    }
    try {
      print("Trying to send OTP");

      final res = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin/generateOTP/login'),
        body: jsonEncode({
          'emailOrMobileNumber': email,
          'password': pass,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final Map<String, dynamic> response = jsonDecode(res.body);

      print(res.statusCode);
      print("object");
      print(response["token"].toString());

      if (res.statusCode == 200) {
        // Successfully sent OTP, store the token and navigate to Verifyotp screen
        await saveToken(response["token"].toString());
        print("object${response["token"].toString()}");

        // Successfully sent OTP, navigate to Verifyotp screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verifyotp(
              email: email,
              screenName: 'login',
              pass: '',
            ),
          ),
        );
      } else {
        // Show error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Something went wrong...'),
              content: Text(response['message']),
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
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Something went wrong...'),
            content: Text(e.toString()),
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

  void loginAsAdmin(BuildContext context) {
    // Implement your admin login logic here
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Logging in as Admin')));
  }

  void loginAsStudent(BuildContext context) {
    // Implement your student login logic here
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Logging in as Student')));
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
                            "Login Now",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Fill the login details",
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: "admin@mpsgroup.org.in",
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return 'email empty';
                              }
                              return null;
                            }),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return 'pass empty';
                              }
                              return null;
                            }),
                            controller: _passController,
                            decoration: const InputDecoration(
                              hintText: "password",
                              prefixIcon: Icon(Icons.password),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => loginAccount(
                                  _emailController.text,
                                  _passController.text,
                                  context),
                              child: const Text("Send OTP"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const StudentDashBoard(),
                                        ));
                                  },
                                  child: const Text(
                                    "Login As Student",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ragisterEmail(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Create a new account",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const mainHomePage(),
                                        ));
                                  },
                                  child: const Text(
                                    "Login As Professor",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
