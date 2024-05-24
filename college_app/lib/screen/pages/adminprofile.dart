import 'dart:convert';
import 'package:college_app/modal/profile_model_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailsOfAdmin extends StatefulWidget {
  @override
  _DetailsOfAdminState createState() => _DetailsOfAdminState();
}

class _DetailsOfAdminState extends State<DetailsOfAdmin> {
  late Future<ProfileModelClass> _futureProfile;

  @override
  void initState() {
    super.initState();
    _futureProfile = fetchAdminProfile();
  }

  Future<ProfileModelClass> fetchAdminProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('http://localhost:3000/api/v1/admin/get/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return ProfileModelClass.fromJson(responseData['admin']);
    } else {
      throw Exception('Failed to load profile: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProfileModelClass>(
        future: _futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final profile = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(profile.avatar),
                                radius: 50,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${profile.firstName}" " ${profile.lastName}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(profile.email),
                              Text(profile.mobileNo.toString()),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: const Text('Full Name'),
                                    subtitle: Text(
                                        '${profile.firstName} ${profile.lastName} '),
                                  ),
                                  ListTile(
                                    title: const Text('Email'),
                                    subtitle: Text(profile.email),
                                  ),
                                  ListTile(
                                    title: const Text('Phone'),
                                    subtitle: Text(profile.mobileNo.toString()),
                                  ),
                                  ListTile(
                                    title: const Text('Mobile'),
                                    subtitle: Text(profile.mobileNo.toString()),
                                  ),
                                  ListTile(
                                    title: const Text('Address'),
                                    subtitle: Text(
                                        "${profile.currentAddress.postalCode}"),
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Edit'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'View Your Document',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(profile.documents.pic),
                                    ),
                                    title: const Text(
                                      "View your Profile",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          profile.documents.signatureImg),
                                    ),
                                    title: const Text(
                                      "View your signature",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          profile.documents.bankDetails),
                                    ),
                                    title: const Text(
                                      "View your Bank Passbook",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          profile.documents.resumeOrCv),
                                    ),
                                    title: const Text(
                                      "View your Resume",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'All Account Details',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(profile.fatherName),
                                  const SizedBox(height: 8),
                                  Text(profile.email),
                                  const SizedBox(height: 8),
                                  Text(profile.religion),
                                  const SizedBox(height: 8),
                                  Text(profile.dob),
                                  const SizedBox(height: 8),
                                  Text(profile.gender),
                                  const SizedBox(height: 8),
                                  Text(profile.martialStatus),
                                  const SizedBox(height: 8),
                                  Text(profile.nationalId),
                                  const SizedBox(height: 8),
                                  Text(profile.nationalIdNumber.toString()),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No profile data found'));
          }
        },
      ),
    );
  }
}
