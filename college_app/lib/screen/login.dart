import 'package:college_app/screen/ragister.dart';
import 'package:college_app/screen/varify_otp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
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
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "admin@mpsgroup.org.in",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Verifyotp(
                                      email: _emailController.text,
                                      screenName: "login"),
                                ),
                              );
                            },
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
                                  builder: (context) => ragisterEmail(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
