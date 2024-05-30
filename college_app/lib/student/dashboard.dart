import 'package:college_app/shared_preference_class_get_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentDashBoard extends StatefulWidget {
  const StudentDashBoard({super.key});

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

TextEditingController _searchStudetnController = TextEditingController();

class _StudentDashBoardState extends State<StudentDashBoard> {
  Future getStudentProfile() async {
    print(_searchStudetnController.text);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString("token");

    var res = await http.get(
      Uri.parse(
          "http://localhost:3000/api/v1/admin/get/student/:mobile_no?vrfNameOrNumber=${_searchStudetnController.text}"),
      headers: <String, String>{
        "Authorization": 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      print("student api profile working properly");
    } else {
      print(res.body);
      print(res.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("find student");
    return Material(
      child: Center(child: studentprofile()),
    );
  }

  Widget studentprofile() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildWideContainers(context);
        } else {
          return _buildNarrowContainers(context);
        }
      },
    );
  }

  Widget _buildWideContainers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildProfileCard(context),
                SizedBox(height: 16.0),
                _buildSettingsCard(context),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 3,
            child: _buildBillsCard(context),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowContainers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildProfileCard(context),
          SizedBox(height: 16.0),
          _buildSettingsCard(context),
          SizedBox(height: 16.0),
          _buildBillsCard(context),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/profile.jpg'), // Replace with your image asset
            ),
            SizedBox(height: 16.0),
            Text(
              'Sami Rahman',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            Text('sami.rahman2002@gmail.com'),
            SizedBox(height: 8.0),
            Text('+1 555-569-1236'),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Edit Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Bills',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone Bill'),
              trailing: Text('Paid', style: TextStyle(color: Colors.green)),
            ),
            ListTile(
              leading: Icon(Icons.wifi),
              title: Text('Internet Bill'),
              trailing: Text('Unpaid', style: TextStyle(color: Colors.red)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('House Rent'),
              trailing: Text('Paid', style: TextStyle(color: Colors.green)),
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text('Income Tax'),
              trailing: Text('Paid', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}
