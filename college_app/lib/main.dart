import 'package:college_app/screen/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const splash();
  }
}
