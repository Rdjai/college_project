import 'package:college_app/screen/addnew/proffesor_add.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class addProfessor extends StatefulWidget {
  const addProfessor({super.key});

  @override
  State<addProfessor> createState() => _addProfessorState();
}

class _addProfessorState extends State<addProfessor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, right: 18, left: 18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add Student",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Colors.black45,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            professoradd()
          ],
        ),
      ),
    );
  }
}
