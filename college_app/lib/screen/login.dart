import 'dart:convert';
import 'package:college_app/screen/pages/home.dart';
import 'package:college_app/screen/ragister.dart';
import 'package:college_app/screen/varify_otp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future loginAccount(String email, String pass, BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print("object");
      return;
    }
    try {
      print("try block");

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
      final Map<String, dynamic> errorresponse = jsonDecode(res.body);

      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('something wrong... '),
              content: Text(errorresponse['message']),
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

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Verifyotp(
                email: email,
                screenName: 'login',
                pass: '',
              ),
            ));
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('something wrong... ?'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  print("object");
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
                      color: Color.fromRGBO(255, 255, 255, 0.619),
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
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Create a new account",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
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
