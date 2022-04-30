import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoachWorkoutScreen extends StatefulWidget {
  const CoachWorkoutScreen({Key? key}) : super(key: key);

  @override
  _CoachWorkoutScreenState createState() => _CoachWorkoutScreenState();
}

class _CoachWorkoutScreenState extends State<CoachWorkoutScreen> {
  var workoutName;
  var className;
  var classCode;

  CollectionReference workouts =
      FirebaseFirestore.instance.collection('workouts');
  CollectionReference classes =
      FirebaseFirestore.instance.collection('classes');

  _CoachWorkoutScreenState() {
    workoutName = "workout";
    className = "class";

    //firebase call to get classCode
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUserUid = auth.currentUser?.uid;

    FirebaseFirestore.instance
    .collection("users")
    .doc(currentUserUid)
    .get()
    .then((DocumentSnapshot docSnapshot) {
      classCode = docSnapshot.data()?["classroom_codes"];
    });
  }

  void goBack() {
    // go back a page
  }

  @override
  Widget build(BuildContext context) {
    /*
    debugPrint(imageStrings.toString());
    return Text(imageStrings.toString());
    */
    debugPrint("build things");
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("Coach Workout"),
            actions: [
              TextButton(
                child: const Text("Back"),
                onPressed: goBack,
              ),
            ]),
        body: Column(children: [
          const Text('Choose Workout for your class:'),
          Expanded(
              child: SizedBox(
            height: 300,
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    child: const Center(child: Text('Workout 1')),
                  ),
                  Container(
                    child: const Center(child: Text('Workout 2')),
                  ),
                ]),
          )),
        ]));
  }
}
