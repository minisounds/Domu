import 'package:domu/screens/homeCoach.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoachWorkoutScreen extends StatefulWidget {
  const CoachWorkoutScreen({Key? key}) : super(key: key);

  @override
  _CoachWorkoutScreenState createState() => _CoachWorkoutScreenState();
}

class _CoachWorkoutScreenState extends State<CoachWorkoutScreen> {
  var workoutNames = [];
  var className;
  var classCode;
  var selectedWorkout;
  final workoutNameController = TextEditingController();

  CollectionReference workouts =
      FirebaseFirestore.instance.collection('workouts');
  CollectionReference classes =
      FirebaseFirestore.instance.collection('classes');

  _CoachWorkoutScreenState() {
    // workoutName = "workout";
    className = "class";

    //firebase call to get classCode
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUserUid = auth.currentUser?.uid;

    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserUid)
        .get()
        .then((DocumentSnapshot docSnapshot) {
      classCode = docSnapshot.data()?["classroomCode"];
      setState(() {
        classCode;
      });
    });

    FirebaseFirestore.instance
        .collection("workouts")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        workoutNames.add(doc["name"]);
      }
      setState(() {
        workoutNames;
      });
    });
  }

  void goBack() {
    // go back a page
  }

  List<Widget> renderWorkoutNames() {
    List<Widget> list = [];
    for (var i = 0; i < workoutNames.length; i++) {
      list.add(Text(workoutNames[i]));
    }

    return list;
  }

  void chooseWorkout(String workoutName) async {
    // workoutName = workoutNameController.text;
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUserUid = auth.currentUser?.uid;
    var docId;

    if(workoutNames.contains(workoutName)){
      await FirebaseFirestore.instance
        .collection("classrooms")
        .where("classroomCode", isEqualTo: classCode)
        .get()
        .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          docId = doc.id;
        }
      });

      FirebaseFirestore.instance.collection("classrooms").doc(docId).update({
        "workoutName": workoutName,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeCoachScreen()));
    }

    


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
          title: const Text(
            "Coach Workout",
          ),
          actions: [
            TextButton(
              child: const Text("Back"),
              onPressed: goBack,
            ),
          ]),
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: const Text(
            'Choose Workout for your class:',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        RadioListTile<String>(
          title: const Text('Beginner Workout (5-7 year old)'),
          value: 'BeginnerWorkout',
          groupValue: selectedWorkout,
          onChanged: (String? value) {
            setState(() {
              selectedWorkout = value;
            });

            chooseWorkout("BeginnerWorkout");
          },
        ),
        RadioListTile<String>(
          title: const Text('Intermediate Workout (7-10 year old)'),
          value: 'IntermediateWorkout',
          groupValue: selectedWorkout,
          onChanged: (String? value) {
            setState(() {
              selectedWorkout = value;
            });

            chooseWorkout("IntermediateWorkout");
          },
        ),
        ElevatedButton(
            child: const Text("Go Back Home"),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeCoachScreen()),
              );
            }),
      ]),

      // Expanded(
      //     child: SizedBox(

      //       height: 300,
      //       child: ListView(

      //         shrinkWrap: true,
      //         padding: const EdgeInsets.all(8),
      //         children: renderWorkoutNames(),
      //       ),
      // )),
      // TextField(
      //   controller: workoutNameController,
      //   decoration: const InputDecoration(
      //     border: OutlineInputBorder(),
      //     hintText: 'Enter name of the workout here:',
      //   ),
      // ),
      // TextButton(
      //   child: const Text("Choose"),
      //   onPressed: chooseWorkout,
      // ),
    );
  }
}
