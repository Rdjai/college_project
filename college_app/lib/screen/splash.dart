import 'dart:async';

import 'package:college_app/screen/login.dart';
import 'package:college_app/screen/signup.dart';
import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => createProfile())));
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    });
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
