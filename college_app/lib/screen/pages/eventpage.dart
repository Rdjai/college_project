import 'package:college_app/screen/home/student.dart';
import 'package:college_app/screen/pages/studentList.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
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
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Column(
                children: [partyDetails()],
              ),
              Column(
                children: [khatanahaikarale()],
              )
            ],
          )
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
            margin: EdgeInsets.all(17),
            child: Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.height / 8,
              child: Column(
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
              padding: EdgeInsets.all(25),
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.height / 2,
              child: Column(
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
}
