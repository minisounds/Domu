import 'package:domu/screens/homeCoach.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:domu/screens/homeStudent.dart';
import 'package:flutter/material.dart';
import '../widgets/labeledCheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCoachClassroomScreen extends StatefulWidget {
  const CreateCoachClassroomScreen({Key? key}) : super(key: key);

  @override
  State<CreateCoachClassroomScreen> createState() =>
      _CreateCoachClassroomScreenState();
}

class _CreateCoachClassroomScreenState
    extends State<CreateCoachClassroomScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  _CreateCoachClassroomScreenState() {
    getClassroomCode();
  }

  String classroomCode = "";

  void getClassroomCode() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(auth.currentUser?.uid);
        print('Document data: ${documentSnapshot.data()}');
        setState(() {
          classroomCode = documentSnapshot.data()?['classroom_codes'];
        });
      } else {
        print("this document didn't exist");
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Here: render classroom code to screen. Maybe in the future generate a custom link for them
    return Scaffold(
        appBar: AppBar(
          title: const Text("Join Classroom Page"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Center(
                    child: Row(children: [
                  const Text("Classroom Code: ",
                      style: TextStyle(fontSize: 20)),
                  Text(classroomCode,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))
                ]))),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Text(
                "Make sure to note down this code to send to your students!",
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    child: const Text("Start Assigning Workouts To Your Kids!"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeCoachScreen()),
                      );
                    }))
          ]),
        ));
  }
}
