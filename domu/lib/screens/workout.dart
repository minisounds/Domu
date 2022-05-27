import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
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
  var exerciseTime = 30;
  var _countDownController;

  CollectionReference workouts =
      FirebaseFirestore.instance.collection('workouts');

  _WorkoutScreenState() {
    _countDownController = CountDownController();
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
      _countDownController.restart();
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
            child: CircularCountDownTimer(
              duration: 30,
              initialDuration: 0,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Colors.purpleAccent[100]!,
              fillGradient: null,
              backgroundColor: Colors.purple[500],
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                  fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.S,
              controller: _countDownController,
              autoStart: true,
              onComplete: changeWorkoutImage,
            ),
            padding: const EdgeInsets.all(5.0),
          ),
          /*
          Container(
            child: TextButton(
              child: const Text("Next"),
              onPressed: changeWorkoutImage,
            ),
            padding: const EdgeInsets.all(5.0),
          )
          */
        ])));
  }
}
