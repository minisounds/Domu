import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_timer/simple_timer.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  int index = 0;
  var imageStrings = [];
  var exerciseNames = [];
  var workoutName = "workout1";
  final TimerStyle _timerStyle = TimerStyle.ring;

  CollectionReference workouts =
      FirebaseFirestore.instance.collection('workouts');

  _WorkoutScreenState() {
    debugPrint("Workout");
    imageStrings.add(
        "https://cdn.cloudflare.steamstatic.com/steam/apps/945360/capsule_616x353.jpg?t=1646296970");
    exerciseNames.add("amongus");
    firebasePulls();
  }

  void firebasePulls() async {
    await FirebaseFirestore.instance
        .collection('workouts')
        .where('name', isEqualTo: workoutName)
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        debugPrint("Firebase");
        var exerciseMap = data["exerciseMap"];
        for (var exerciseName in exerciseMap.keys) {
          exerciseNames.add(exerciseName);
        }
        for (var exerciseLink in exerciseMap.values) {
          imageStrings.add(exerciseLink);
        }
        setState(() {
          exerciseMap;
          imageStrings;
        });
      }
    });
  }

  void changeWorkoutImage() {
    setState(() {
      if (index < (imageStrings.length - 1)) {
        index += 1;
        //endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
        //reset timer
      }
    });
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
            title: const Text("Workout"),
            actions: [
              Container(
                alignment: Alignment.topRight,
              )
              //put workout progress here?
            ]),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            child: Text(exerciseNames[index]),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
          ),
          Container(
            child: Image.network(imageStrings[index]),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(18.0),
          ),
          Container(
            height: 100,
            child: SimpleTimer(
              status: TimerStatus.start,
              duration: Duration(seconds: 30),
              //controller: _timerController,
              timerStyle: _timerStyle,
            ),
            padding: const EdgeInsets.all(5.0),
          ),
          Container(
            child: TextButton(
              child: const Text("Next"),
              onPressed: changeWorkoutImage,
            ),
            padding: const EdgeInsets.all(5.0),
          )
        ])));
  }
}
