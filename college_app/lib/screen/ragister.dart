import 'package:college_app/screen/login.dart';
import 'package:college_app/screen/varify_otp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toastification/toastification.dart';

class ragisterEmail extends StatelessWidget {
  const ragisterEmail({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();

    Future sendOTP(String email) async {
      try {
        var res = await http.post(
          Uri.parse('http://localhost:3000/api/v1/admin/generateOTP/signup'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'email': email}),
        );

        if (res.statusCode == 201) {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Verifyotp(
                  email: email,
                  screenName: 'register',
                  pass: '',
                ),
              ));
          // ignore: use_build_context_synchronously
          return toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flat,
            autoCloseDuration: const Duration(seconds: 5),
            title: Text('Otp send successfully on $email'),
            // you can also use RichText widget for title and description parameters
            description: RichText(
                text: const TextSpan(text: 'Otp validate only 1 minute ')),
            alignment: Alignment.topRight,
            direction: TextDirection.ltr,
            animationDuration: const Duration(milliseconds: 300),
            animationBuilder: (context, animation, alignment, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            icon: const Icon(Icons.check),
            primaryColor: Colors.green,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x07000000),
                blurRadius: 16,
                offset: Offset(0, 16),
                spreadRadius: 0,
              )
            ],
            showProgressBar: true,
            closeButtonShowType: CloseButtonShowType.onHover,
            closeOnClick: false,
            pauseOnHover: true,
            dragToClose: true,
            applyBlurEffect: true,
            callbacks: ToastificationCallbacks(
              onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
              onCloseButtonTap: (toastItem) =>
                  print('Toast ${toastItem.id} close button tapped'),
              onAutoCompleteCompleted: (toastItem) =>
                  print('Toast ${toastItem.id} auto complete completed'),
              onDismissed: (toastItem) =>
                  print('Toast ${toastItem.id} dismissed'),
            ),
          );
        } else {
          try {
            var errorData = jsonDecode(res.body);
          } catch (error) {}
        }
      } catch (e) {
        print(e);
      }
    }

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
                      color: const Color.fromRGBO(255, 255, 255, 0.619),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min MainAxisSize
                      children: [
                        const Text(
                          "Verify Email Address",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Enter your Email address",
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          controller: emailcontroller,
                          decoration: const InputDecoration(
                            hintText: "xyz@email.com",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              String email = emailcontroller.text.trim();
                              if (email.isNotEmpty) {
                                sendOTP(email);

                                // Add code here to handle OTP sent successfully
                              } else {}
                            },
                            child: const Text("Send OTP"),
                          ),
                        ),
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
                              "I have an account Login",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
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
