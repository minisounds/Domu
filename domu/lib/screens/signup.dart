import 'package:domu/screens/homeCoach.dart';
import 'package:domu/screens/createCoachClassroom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:domu/screens/homeStudent.dart';
import 'package:domu/screens/studentJoinClassroom.dart';
import 'package:flutter/material.dart';
import '../globalVars.dart' as globals;
import '../utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/labeledCheckbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void createClassroom() async {
    CollectionReference classrooms =
        FirebaseFirestore.instance.collection('classrooms');

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //auto generate 6 dig number
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    String classroomCode = code.toString();

    // creates classroom
    await classrooms
        .add({
          'classroomCode':
              classroomCode, // Replace with automatically generated number
          'classroomName': nameController.text + 's Classroom'
        })
        .then((value) => print("Classroom Added"))
        .catchError((error) => print("Failed to add user: $error"));

    await users
        .doc(auth.currentUser?.uid)
        .update({'classroom_codes': classroomCode});
    // add classroom code to coach's user properties under "classroom_codes"
  }

  //function to decide where to direct the user. Check if user exists, then check if user is coach or not. Void return, handle redirects in function
  Future<void> redirectUser() async {
    print("hello");
    print(globals.user?.uid);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic>? userData = await getUserDataByID(globals.user?.uid);

    if (userData != null) {
      // check identity of user
      if (userData["identity"] == "Coach") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeCoachScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeStudentScreen()),
        );
      }
    }
  }

  Future<void> createAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      String? uid = auth.currentUser?.uid;
      if (uid == null) {
        throw Exception('uid Null');
      }

      var identity = "Coach";
      //if identity is selected as Student, creates an account w/o classroom code
      if (_isSelected2 == true) {
        identity = "Student";
        await users.doc(userCredential.user?.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'identity': identity,
          'classroom_codes': [],
        });
        print("Student Account Created");
      } else {
        //if identity is coach, then creates a classroom and adds the id to the coach's classroom codes property
        await users.doc(userCredential.user?.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'identity': identity,
          'classroom_codes': []
        });
        createClassroom();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // auth.signOut();
    // print("user signed out!");
    redirectUser();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Signup Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: const Text(
                  "Name:",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 100,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name here',
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: const Text(
                  "Email:",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 100,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: const Text(
                  'Password: ',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password here',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Are you a Coach, or Student?",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            LabeledCheckbox(
                label: "Coach",
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                value: _isSelected1,
                onChanged: (bool newValue) {
                  setState(() {
                    _isSelected1 = newValue;
                  });
                }),
            LabeledCheckbox(
                label: "Student",
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                value: _isSelected2,
                onChanged: (bool newValue) {
                  setState(() {
                    _isSelected2 = newValue;
                  });
                }),
            Container(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  child: const Text("Create Your Account and Get In Class!"),
                  onPressed: () async {
                    //Create a new firebase account here.
                    await createAccount();

                    // if user is a Coach, take him/her to Coach Classroom Screen, where they can see their classroom code and share with students
                    if (_isSelected1 == true) {
                      // createClassroom();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CreateCoachClassroomScreen()),
                      );
                    } else {
                      // if user is student, take them to Student Classroom Screen, where they can input and join a classroom
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentJoinClassroom()),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  // }
}
