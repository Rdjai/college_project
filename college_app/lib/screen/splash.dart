import 'dart:async';
import 'package:college_app/screen/login.dart';
import 'package:college_app/screen/pages/home.dart';
import 'package:college_app/shared_preference_class_get_delete.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> checkToken() async {
    final String? token = await SharedPreferenceHelper.getToken();
    final int? tokenTimestamp =
        await SharedPreferenceHelper.getTokenTimestamp();
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    print("Current timestamp: $currentTimestamp");
    print("Stored token: $token");
    print("Stored token timestamp: $tokenTimestamp");

    if (token != null && tokenTimestamp != null) {
      final int elapsedTime = currentTimestamp - tokenTimestamp;
      print("Elapsed time: $elapsedTime ms");

      if (elapsedTime > 24 * 60 * 60 * 1000) {
        // 24 hours in milliseconds
        print('Token deleted after 24 hours');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } else {
        print('Token is still valid.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const mainHomePage(),
          ),
        );
      }
    } else {
      print('No token found');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(
              width: MediaQuery.of(context).size.height / 0.9,
              child: const LinearProgressIndicator(
                color: Color.fromRGBO(42, 20, 113, 1),
                semanticsValue: 'Linear progress indicator',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
