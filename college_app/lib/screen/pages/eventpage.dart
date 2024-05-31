import 'dart:convert';
import 'package:intl/intl.dart';
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

class _EventPageState extends State<EventPage> {
  late String eventdate;
  List events = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      final res = await http.get(
        Uri.parse('http://localhost:3000/api/v1/events/all_events'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Fetch events response status: ${res.statusCode}');
      debugPrint('Fetch events response body: ${res.body}');

      if (res.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(res.body);
        if (response['success']) {
          setState(() {
            events = response['events'];
          });
        } else {
          debugPrint('Fetch events failed: ${response['message']}');
        }
      } else {
        debugPrint('Failed to load events with status code: ${res.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
    }
  }

  Future<void> _callEventApi(BuildContext context) async {
    print(eventdate); // Debug the event date
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      // Format the event date
      final formattedDate =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(eventdate));

      final res = await http.post(
        Uri.parse('http://localhost:3000/api/v1/admin/create/event'),
        body: jsonEncode({
          "title": _eventtitlecontrol.text,
          "description": _eventdescriptioncontrol.text,
          "department": _eventdepartmentcontrol.text, // Send as string
          "semester": _eventsemestercontrol.text, // Send as string
          "event_date": eventdate,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response status: ${res.statusCode}');
      debugPrint('Response body: ${res.body}');
      final Map<String, dynamic> response = jsonDecode(res.body);
      debugPrint('Response body (decoded): $response');

      if (res.statusCode == 200) {
        // Successfully created event
        if (mounted) {
          Navigator.pop(context); // Close the dialog
        }
        _fetchEvents(); // Refresh event list after adding new event
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
    return SingleChildScrollView(
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
                  subtitle: "Event For You this week",
                  icon: Icons.hourglass_bottom),
              GestureDetector(
                child: PerformanceCard(
                    title: "Add Event",
                    subtitle: "To plan your week",
                    icon: Icons.add),
                onTap: () {
                  _showAddEventDialog(context);
                },
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: events.map((event) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'] ?? 'No Title',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    event['description'] ?? 'No Description',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 17,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        DateFormat('dd MMM yyyy')
                            .format(DateTime.parse(event['event_date'])),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 16.0),
                      Icon(
                        Icons.place,
                        size: 17,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        event['department']['name'] ?? 'No Department',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
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
                onDateSelected: (selectedDate) {
                  setState(() {
                    eventdate = DateFormat('yyyy-MM-dd').format(selectedDate);
                  });
                },
                text: "select date",
              ),
              ElevatedButton(
                  onPressed: () {
                    _callEventApi(context);
                  },
                  child: const Text("Create Event")),
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

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Event'),
          content: _EventPushPage(),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
