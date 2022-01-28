import 'package:domu/screens/homeCoach.dart';
import 'package:domu/screens/homeStudent.dart';
import 'package:flutter/material.dart';
import '../widgets/labeledCheckbox.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  @override
  Widget build(BuildContext context) {
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
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name here',
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
              child: const TextField(
                decoration: InputDecoration(
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
            // Container(
            //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            //   alignment: Alignment.centerLeft,
            //   child: const Text(
            //     "*IF COACH* Coach 6 Digit Classroom Code: NRMQ7J",
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
            // Container(
            //     padding: const EdgeInsets.all(0),
            //     child: TextButton(
            //       child: const Text("Return Home"),
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const HomeCoachScreen()),
            //         );
            //       },
            //     )),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Enter 6 Digit Classroom Code:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your 6 Digit Classroom Code',
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  child: const Text("Go to Home Page"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeStudentScreen()),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
