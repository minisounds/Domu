import 'dart:ffi';
import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:domu/screens/homeStudent.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:domu/screens/workoutCompleted.dart';
import '../utils.dart';

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
  var workoutName = "BeginnerWorkout";
  var exerciseTime = 60;
  var _countDownController;
  String currentExerciseName = "";
  final audioPlayer = AudioPlayer();
  Map<String, int> timeMap = <String, int>{};
  bool isLoaded = false;
  bool blobOn = true;
  String nextExerciseName = "";

  CollectionReference workouts =
      FirebaseFirestore.instance.collection('workouts');

  _WorkoutScreenState() {
    _countDownController = CountDownController();
    debugPrint("Workout");

    firebasePulls();
  }

  void firebasePulls() async {
    var exerciseMap = await getWorkoutMap();
    var firebaseTimeMap = await getTimeMap();
    workoutName = await getWorkoutName();
    var exerciseMapKeys = exerciseMap!.keys;
    for (int i = 0; i < exerciseMapKeys.length; i++) {
      exerciseNames.add(exerciseMapKeys.elementAt(i));
    }
    for (var exerciseLink in exerciseMap.values) {
      imageStrings.add(exerciseLink);
      imageStrings.add(
          "https://cdn.pixabay.com/photo/2021/02/12/13/43/among-us-6008615__340.png");
    }
    setState(() {
      exerciseMap;
      timeMap = firebaseTimeMap!;
      imageStrings;
      isLoaded = true;
    });
    currentExerciseName = "Domu";
    for (var elem in exerciseNames[0].split(" ")) {
      currentExerciseName += elem;
    }
  }

  void drillCompletedSound() async {
    await audioPlayer.play(AssetSource('sounds/DomuDrillCompleted.mp3'));
  }

  void blobAnimation() async {
    setState(() {
      blobOn = !blobOn;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      blobOn = !blobOn;
    });
    var exerciseDuration = timeMap[exerciseNames[index]];
    await Future.delayed(const Duration(seconds: 1));
    _countDownController.restart(duration: exerciseDuration);
  }

  void changeWorkoutImage() async {
    setState(() {
      if (index < (exerciseNames.length - 1)) {
        index += 1;
        blobAnimation();
        drillCompletedSound();
        if ((index + 1) < exerciseNames.length) {
          nextExerciseName = exerciseNames[index + 1];
        } else {
          nextExerciseName = "";
        }

        currentExerciseName = "Domu";
        for (var elem in exerciseNames[index].split(" ")) {
          currentExerciseName += elem;
        }
        
      } else {
        //Show that workout is finished somehow
        //add points
        addPoints();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WorkoutCompleted()),
        );
      }
    });
  }

  int getExerciseDuration() {
    if (timeMap.isNotEmpty && timeMap[exerciseNames[index]] != null) {
      return timeMap[exerciseNames[index]]!;
    } else {
      return 5;
    }
  }

  String getExerciseTitle() {
    return exerciseNames.isNotEmpty
        ? (index % 2 == 0
            ? exerciseNames[index]
            : "Next Exercise:\n$nextExerciseName")
        : "Name";
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build things");
    if (!isLoaded) {
      return const Scaffold();
    }
    return Scaffold(
        appBar: AppBar(title: const Text("Workout"), actions: [
          Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Progress: ${index + 1} / ${imageStrings.length / 2}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ))
        ]),
        body: SingleChildScrollView(
            child: Column(children: [
          Center(
            child: AnimatedContainer(
              width: blobOn ? 0 : MediaQuery.of(context).size.width,
              height: blobOn ? 0 : MediaQuery.of(context).size.height,
              color: Colors.blue,
              alignment:
                  blobOn ? Alignment.center : AlignmentDirectional.center,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              // curve: Curves.fastOutSlowIn,
              child: const Text("Switching Workouts Now!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                  )),
            ),
          ),
          Container(
            child: Text(
              "${exerciseNames[index]}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
              //maximum height set to 100% of vertical height
            ),
            child: Image.asset(
                exerciseNames.isNotEmpty
                    ? "assets/$workoutName/$currentExerciseName.gif"
                    : "assets/images/loadingImage.png",
                scale: 0.8),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(18.0),
          ),
          Container(
            height: 100,
            child: CircularCountDownTimer(
              duration: getExerciseDuration(),
              initialDuration: 0,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.blue[100]!,
              ringGradient: null,
              fillColor: Colors.blueAccent[100]!,
              fillGradient: null,
              backgroundColor: Colors.blue[500],
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                  fontSize: 33.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.S,
              controller: _countDownController,
              autoStart: true,
              isReverse: true,
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
