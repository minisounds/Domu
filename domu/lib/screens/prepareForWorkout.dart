import 'package:domu/screens/workout.dart';
import 'package:domu/utils.dart';
import 'package:flutter/material.dart';
import 'package:domu/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils.dart';

class PrepareForWorkoutScreen extends StatefulWidget {
  const PrepareForWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<PrepareForWorkoutScreen> createState() =>
      _PrepareForWorkoutScreenState();
}

class _PrepareForWorkoutScreenState extends State<PrepareForWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Domú",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.asset('assets/images/tenniskidpic.png'),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: const Text(
                        "Note Before Starting",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/images/tenniskidpic.jpeg',
                          scale: 5)),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: RichText(
                      text: const TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Before Starting Your Workout, Please Find a Spot'),
                          TextSpan(
                              text: ' Outside ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: "With Your Racquet!"),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WorkoutScreen()),
                        );
                      },
                      child: const Text("PROCEED TO WORKOUT (10 min)")),
                ],
              ),
            ),
          ],
        ),
        // ],
      ),
      // ),
    );
  }
}
