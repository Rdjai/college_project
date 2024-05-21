import 'dart:async';
import 'dart:convert';

import 'package:college_app/screen/login.dart';
import 'package:college_app/screen/pages/home.dart';
import 'package:college_app/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:slide_countdown/slide_countdown.dart';

const defaultDuration = Duration(seconds: 60);

class Verifyotp extends StatefulWidget {
  final String email;
  final String screenName;
  final String pass;
  const Verifyotp(
      {required this.email, required this.screenName, required this.pass});

  @override
  State<Verifyotp> createState() => _VerifyotpState();
}

class _VerifyotpState extends State<Verifyotp> {
  String otp = '';
  // final String apiUrl = 'http://localhost:3000/api/v1/admin/verifyOTP/signup';
  Future<void> otpVerify(
    String email,
    String otp,
  ) async {
    try {
      String otpUri = '';
      String loginUri =
          'http://localhost:3000/api/v1/admin/login?otp=${otp}&emailOrMobileNumber=${email}';

      String ragisterUri =
          'http://localhost:3000/api/v1/admin/verifyOTP/signup?email=$email&otp=$otp';

      if (widget.screenName == 'login') {
        otpUri = loginUri;
      } else {
        otpUri = ragisterUri;
      }

      http.Response res = await http.get(
        Uri.parse(otpUri),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      final Map<String, dynamic> resBody = jsonDecode(res.body);
      print('Response Status Code: ${res.statusCode}');

      if (res.statusCode == 200) {
        print("API call successful");

        if (widget.screenName == 'register') {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => createProfile()),
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
          print("error ${resBody['message']}");
        }
      } else {
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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
                    'assets/animation/otp.json',
                    width: 300.0,
                  ),
                  const SizedBox(height: 20.0),
                  const SlideCountdown(
                    duration: defaultDuration,
                    separatorType: SeparatorType.title,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text('Localization Custom Duration Title'),
                  ),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min MainAxisSize
                      children: [
                        const Text(
                          "Verify email Now",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Otp send successfully on ${widget.email}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 20.0),
                        OtpTextField(
                          numberOfFields: 5,
                          borderColor: const Color(0xFF512DA8),
                          //set to true to show as box or false to show1 as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            print(code);
                          },
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) {
                            otp = verificationCode;
                          }, // end onSubmit
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              otpVerify(widget.email, otp);
                            },
                            child: const Text("Verify"),
                          ),
                        ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class successOtp extends StatelessWidget {
  const successOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
