import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Workout"),
          actions: [
            Container(
              child: Text("3/7"),
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
            ),
            Container(
              child: const Text("2000"),
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
            ),
          ]),
      body: SizedBox.expand(
        child: Container(
          child: Column(children: const [
            Center(
              child: Card(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Text("Card"),
                )
              ),
            ),
          ]),
          alignment: Alignment.center,
        )
      )
    );
  }
}
