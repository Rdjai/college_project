import 'package:college_app/screen/home/home.dart';
import 'package:college_app/screen/studentRegistration/newragister.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<String, Widget> _screen = {
    'Home': const HomeWidget(),
    'New_Registration': ResponsiveForm()
  };
  String _selectedScreen = "Home";

  void _ontap(String ScreenName) {
    setState(() {
      _selectedScreen = ScreenName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(241, 240, 243, 1),
        appBar: AppBar(
          elevation: 0.1,
          leading: Padding(
              padding: const EdgeInsets.all(7),
              child: Image.asset("assets/img/logo.png")),
          title: const Text(
            'Dr. Mps group of institution',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Row(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _selectedScreen = 'Home';
                      });
                    },
                    leading: const CircleAvatar(
                      child: Icon(Icons.home),
                    ),
                    title: const Text("Dashboard"),
                  ),
                  ExpansionTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.account_balance)),
                    title: const Text('Admission'),
                    children: [
                      ListTile(
                        title: const Text('- Applications'),
                        onTap: () {
                          // Handle submenu item 1 tap
                        },
                      ),
                      ListTile(
                        title: const Text('- New Registration'),
                        onTap: () {
                          // Handle submenu item 2 tap
                          setState(() {
                            _selectedScreen = "New_Registration";
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('- Student List'),
                        onTap: () {
                          // Handle submenu item 2 tap
                        },
                      ),
                    ],
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text("Profile"),
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.phone),
                    ),
                    title: Text("Contact us"),
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.developer_mode),
                    ),
                    title: Text("Developers"),
                  ),
                ],
              ),
            ),
          )),
          Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromRGBO(241, 242, 251, 3),
                  child: _screen[_selectedScreen] ?? const HomeWidget(),
                ),
              ))
        ]),
      ),
    ));
  }
}
