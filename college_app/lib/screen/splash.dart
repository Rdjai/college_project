// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:college_app/screen/login.dart';
import 'package:college_app/screen/pages/home.dart';
import 'package:college_app/screen/signup.dart';
import 'package:college_app/shared_preference_class_get_delete.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:lottie/lottie.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  Future getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    if (token != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const mainHomePage(),
          ));
      print('Stored token: $token');
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
      print('No token found');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(getToken());
    getToken().then((token) {
      if (token != null) {
        Future.delayed(
          const Duration(hours: 24),
          () => SharedPreferenceHelper.deleteToken(),
        );
      }
    });
    // getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.purple],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/img/logo.png"),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: MediaQuery.sizeOf(context).height / 0.9,
            child: const LinearProgressIndicator(
              color: Color.fromRGBO(42, 20, 113, 1),
              semanticsValue: 'Linear progress indicator',
            ),
          )
        ],
      ),
    ));
  }
}
