import 'package:college_app/responsive/mragister.dart';
import 'package:flutter/material.dart';

class createProfile extends StatefulWidget {
  @override
  _createProfileState createState() => _createProfileState();
}

class _createProfileState extends State<createProfile> {
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return isDesktop(context)
        ? Material(
            child: Center(child: Text("desktop size hai")),
          )
        : msizeSingup();
  }
}
