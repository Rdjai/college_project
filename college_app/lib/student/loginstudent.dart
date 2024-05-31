// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, avoid_print

import 'dart:convert';
import 'package:college_app/screen/pages/home.dart';
import 'package:college_app/screen/ragister.dart';
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

  Future<void> loginAccount(
      String email, String pass, BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print("Form is not valid");
      return;
    }
    try {
      print("Trying to log in");

      final res = await http.get(
        Uri.parse(
            'http://localhost:3000/api/v1/student/getprofile?emailOrMobileNumber=${email}&password=${pass}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> response = jsonDecode(res.body);

      print(res.statusCode);
      print(response["token"].toString());

      if (res.statusCode == 200 && response["success"] == true) {
        // Successfully logged in, store the token and navigate to the dashboard

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDashBoard(
              email,
              pass,
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
      print(e.toString());
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
                            "Student login Now",
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
                              hintText: "Student@mpsgroup.org.in",
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is empty';
                              }
                              return null;
                            },
                            controller: _passController,
                            decoration: const InputDecoration(
                              hintText: "Password",
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
                              child: const Text("Login"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentLoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Login As Student",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ragisterEmail(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Create a new account",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => mainHomePage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Login As Professor",
                                  style: TextStyle(color: Colors.black),
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
