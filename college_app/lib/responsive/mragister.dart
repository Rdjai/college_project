import 'package:college_app/screen/login.dart';
import 'package:college_app/screen/pages/home.dart';
import 'package:college_app/screen/signup.dart';
import 'package:college_app/widgets/dob.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class msizeSingup extends StatefulWidget {
  const msizeSingup({Key? key});

  @override
  State<msizeSingup> createState() => _msizeSingupState();
}

class _msizeSingupState extends State<msizeSingup> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _fatherNameController = TextEditingController();
    final TextEditingController _mobileNoController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _dobController = TextEditingController();
    final TextEditingController _religionController = TextEditingController();
    final TextEditingController _nationalIdNumberController =
        TextEditingController();
    final TextEditingController _joiningDateController =
        TextEditingController();
    final TextEditingController _currentAddressHouseNoController =
        TextEditingController();
    final TextEditingController _currentAddressStreetController =
        TextEditingController();
    final TextEditingController _currentAddressCityController =
        TextEditingController();
    final TextEditingController _currentAddressStateController =
        TextEditingController();
    final TextEditingController _currentAddressPostalCodeController =
        TextEditingController();
    final TextEditingController _qualification1InstituteController =
        TextEditingController();
    final TextEditingController _qualification1NameController =
        TextEditingController();
    final TextEditingController _qualification1YearController =
        TextEditingController();
    final TextEditingController _qualification2InstituteController =
        TextEditingController();
    final TextEditingController _qualification2NameController =
        TextEditingController();
    final TextEditingController _qualification2YearController =
        TextEditingController();
    final TextEditingController _picController = TextEditingController();
    final TextEditingController _signatureController = TextEditingController();
    final TextEditingController _resumeController = TextEditingController();
    final TextEditingController _bankDetailsController =
        TextEditingController();
    final TextEditingController _achievement1NameController =
        TextEditingController();
    final TextEditingController _achievement1DescController =
        TextEditingController();
    final TextEditingController _achievement1LinkController =
        TextEditingController();
    final TextEditingController _achievement2NameController =
        TextEditingController();
    final TextEditingController _achievement2DescController =
        TextEditingController();
    final TextEditingController _achievement2LinkController =
        TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Material(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/accountant.json',
                    width: 250.0,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.619),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Use min MainAxisSize
                        children: [
                          const Text(
                            "create Account Now",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "Fill the Account details",
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 20.0),
                          TextField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              hintText: "last name",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _fatherNameController,
                            decoration: const InputDecoration(
                              hintText: "father name",
                              prefixIcon: Icon(Icons.escalator_warning),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _mobileNoController,
                            decoration: const InputDecoration(
                              hintText: "mobile number",
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: "xyz@email.com",
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          DobPicker(
                              onDateSelected: (p0) => {print(p0)},
                              text: "Date of bearth"),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _religionController,
                            decoration: const InputDecoration(
                              hintText: "Enter Religion",
                              prefixIcon: Icon(Icons.temple_hindu),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _nationalIdNumberController,
                            decoration: const InputDecoration(
                              hintText: "Adhar number",
                              prefixIcon: Icon(Icons.badge),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _currentAddressHouseNoController,
                            decoration: const InputDecoration(
                              hintText: "House number",
                              prefixIcon: Icon(Icons.looks_one),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _currentAddressStreetController,
                            decoration: const InputDecoration(
                              hintText: "Street",
                              prefixIcon: Icon(Icons.streetview),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _currentAddressCityController,
                            decoration: const InputDecoration(
                              hintText: "city",
                              prefixIcon: Icon(Icons.location_city),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _currentAddressStateController,
                            decoration: const InputDecoration(
                              hintText: "State",
                              prefixIcon: Icon(Icons.location_history),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _currentAddressPostalCodeController,
                            decoration: const InputDecoration(
                              hintText: "postel code",
                              prefixIcon: Icon(Icons.local_shipping),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            obscureText: true,
                            controller: _currentAddressPostalCodeController,
                            decoration: const InputDecoration(
                              hintText: "Qualification",
                              prefixIcon: Icon(Icons.school),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                              },
                              child: const Text("Login"),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: const Text(
                                "I have an account login",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
