import 'package:flutter/material.dart';

class popup_notification extends StatefulWidget {
  const popup_notification({super.key});

  @override
  State<popup_notification> createState() => _popup_notificationState();
}

class _popup_notificationState extends State<popup_notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("NOtification"),
      ),
    );
  }
}
