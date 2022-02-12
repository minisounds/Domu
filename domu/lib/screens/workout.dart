import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  String imageString = "assets/sampleWorkoutImage.png";

  void changeWorkout() {
    //do the thing and change the workout for real
    setState(() {
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Column(children: [
          Container(
            child: const Text("Exercise:"),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
          ),
          Container(
            child: Image.asset(imageString),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(18.0),
          ),
          Container(
            child: CountdownTimer(
              endTime: endTime,
            ),
            padding: const EdgeInsets.all(5.0),
          ),
          Container(
            child: TextButton(
              child: const Text("Next"),
              onPressed: changeWorkout,
            ),
            padding: const EdgeInsets.all(5.0),
          )
          
        ]));
  }
}
