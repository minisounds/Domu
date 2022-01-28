import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  void changeWorkout(){
    //do the thing and change the workout for real
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
      body: Column(
        children: [
          Container(
            child: const Text("Card"),
            alignment: Alignment.center,
          ),
          Container(
            child: Image.asset("assets/sampleWorkoutImage.png"),
            alignment: Alignment.center,
          ),
          TextButton(
            child: const Text("Next"),
            onPressed: changeWorkout,
          ),
        ]
      )
    );
  }
}
