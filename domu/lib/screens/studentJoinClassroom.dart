import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:domu/screens/homeStudent.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../globalVars.dart' as globals;

class StudentJoinClassroom extends StatefulWidget {
  const StudentJoinClassroom({Key? key}) : super(key: key);

  @override
  State<StudentJoinClassroom> createState() => _StudentJoinClassroomState();
}

class _StudentJoinClassroomState extends State<StudentJoinClassroom> {
  final classroomCodeController = TextEditingController();

  void addClassroomCode() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(globals.user?.uid)
        .update({'classroom_codes': classroomCodeController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Join Classroom Page"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: classroomCodeController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Classroom Code',
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text("Join Your Classroom And Get Started!"),
                  onPressed: () {
                    addClassroomCode();
                    print("routing to home page");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeStudentScreen()));
                  },
                ))
          ]),
        ));

    // TextFormField(
//   decoration: const InputDecoration(
//     border: UnderlineInputBorder(),
//     labelText: 'Enter your username',
//   ),
// ),
  }
}
