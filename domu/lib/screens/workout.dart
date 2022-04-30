import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  int index = 0;
  var imageStrings = [];
  var workoutName = "workout1";

  CollectionReference workouts =
      FirebaseFirestore.instance.collection('workouts');

  _WorkoutScreenState() {
    debugPrint("Workout");
    imageStrings.add(
        "https://cdn.cloudflare.steamstatic.com/steam/apps/945360/capsule_616x353.jpg?t=1646296970");
    FirebaseFirestore.instance
      .collection('workouts')
      .where('name', isEqualTo: workoutName)
      .get()
      .then((querySnapshot) {
      for(var doc in querySnapshot.docs) {
        var data = doc.data();
        debugPrint("Firebase");
        for (var imgString in data["images"]) {
          imageStrings.add(imgString);
        }
        setState(() {
          imageStrings;
        });
      }
    });
  }

  void changeWorkoutImage() {
    setState(() {
      if (index < (imageStrings.length - 1)) {
        index += 1;
        endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
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
                child: const Text("3/7"),
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10.0),
              ),
              Container(
                child: const Text("2000"),
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10.0),
              ),
            ]),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            child: const Text("Exercise:"),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
          ),
          Container(
            child: Image.network(imageStrings[index]),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(18.0),
          ),
          Container(
            child: CountdownTimer(
              endTime: endTime,
              onEnd: changeWorkoutImage,
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
