import 'dart:convert';

import 'package:college_app/modal/Professor_profile_modal.dart';
import 'package:college_app/screen/home/student.dart';
import 'package:college_app/screen/pages/studentList.dart';
import 'package:college_app/widgets/dob.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

TextEditingController _eventtitlecontrol = TextEditingController();
TextEditingController _eventdescriptioncontrol = TextEditingController();
TextEditingController _eventdepartmentcontrol = TextEditingController();
TextEditingController _eventsemestercontrol = TextEditingController();
var eventdate;

class _EventPageState extends State<EventPage> {
  Future<void> callevntApi(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      // Validate input fields
      if (_eventtitlecontrol.text.isEmpty ||
          _eventdescriptioncontrol.text.length < 50 ||
          _eventdepartmentcontrol.text.isEmpty ||
          _eventsemestercontrol.text.isEmpty) {
        throw Exception(
            'All fields are required and description must be at least 50 characters long.');
      }

      final res = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin/create/event'),
        body: jsonEncode({
          "title": _eventtitlecontrol.text,
          "description": _eventdescriptioncontrol.text,
          "department": {"name": _eventdepartmentcontrol.text},
          "semester": {"name": _eventsemestercontrol.text},
          "event_date": eventdate
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response status: ${res.statusCode}');
      final Map<String, dynamic> response = jsonDecode(res.body);
      debugPrint('Response body: $response');

      if (res.statusCode == 200) {
        // Successfully created event
        if (mounted) {
          Navigator.pop(context); // Close the dialog
        }
      } else {
        // Show error message
        if (mounted) {
          _showErrorDialog(context, response['message']);
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PerformanceCard(
                  title: "Event Created",
                  subtitle: "All event",
                  icon: Icons.check),
              PerformanceCard(
                  title: "1",
                  subtitle: "Event For You this weak",
                  icon: Icons.hourglass_bottom),
              GestureDetector(
                child: PerformanceCard(
                    title: "Add Event",
                    subtitle: "To plan your weak",
                    icon: Icons.add),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: partyDetails(),
              ),
              Expanded(
                child: _EventPushPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget partyDetails() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            margin: const EdgeInsets.all(17),
            child: Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.height / 8,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mon",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text("01")
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              padding: const EdgeInsets.all(25),
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.height / 2,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Meeting introduction",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text("Meeting"),
                  Spacer(),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 17,
                          ),
                          Text(
                            "Meeting introduction",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.place,
                            size: 17,
                          ),
                          Text(
                            "google meet",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _EventPushPage() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              _buildTextField("title", "Enter event title", _eventtitlecontrol),
              _buildTextField("description", "Enter event description",
                  _eventdescriptioncontrol),
              _buildTextField(
                  "department", "Enter department", _eventdepartmentcontrol),
              _buildTextField(
                  "semester", "Enter semester", _eventsemestercontrol),
              DobPicker(
                  onDateSelected: (p0) {
                    setState(() {
                      eventdate = p0.toIso8601String();
                    });
                  },
                  text: "select date"),
              ElevatedButton(
                  onPressed: () {
                    callevntApi(context);
                  },
                  child: Text("Create Event"))
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('College Management System Notification'),
          content: Text(message),
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
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController textControl) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: textControl,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
