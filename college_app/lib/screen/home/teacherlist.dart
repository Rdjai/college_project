import 'package:flutter/material.dart';

class teacherListWidget extends StatefulWidget {
  const teacherListWidget({super.key});

  @override
  State<teacherListWidget> createState() => _teacherListWidgetState();
}

class _teacherListWidgetState extends State<teacherListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Text(
        "tecaher list here",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
