import 'package:flutter/material.dart';
import 'dart:math';
import 'package:countup/countup.dart';
import 'package:domu/screens/homeStudent.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';

class WorkoutCompleted extends StatefulWidget {
  const WorkoutCompleted({Key? key}) : super(key: key);

  @override
  State<WorkoutCompleted> createState() => _WorkoutCompletedState();
}

class _WorkoutCompletedState extends State<WorkoutCompleted> {
  final audioPlayer = AudioPlayer();
  late ConfettiController _controllerTopCenter =
      ConfettiController(duration: const Duration(seconds: 3));

  void dispose() {
    // _controllerTopCenter.dispose();
    _controllerTopCenter.dispose();
    super.dispose();
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  void workoutCompletedSound() async {
    await audioPlayer.play(AssetSource('sounds/DomuWorkoutCompleted.wav'));
  }

  void playConfetti() {
    _controllerTopCenter.play();
  }

  @override
  Widget build(BuildContext context) {
    workoutCompletedSound();
    playConfetti();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Join Classroom Page"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 15, // set a lower max blast force
                minBlastForce: 10, // set a lower min blast force
                emissionFrequency: 0.5,
                numberOfParticles: 30, // a lot of particles at once
                gravity: 1,
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                child: const Text("Workout Completed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ))),
            Center(
              child: Text("Points Won: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                  )),
            ),
            Countup(
              begin: 0,
              end: 6000,
              duration: const Duration(seconds: 2),
              separator: ',',
              style: const TextStyle(
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(30),
                child: ElevatedButton(
                  child: const Text("Go Back Home!"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeStudentScreen()));
                  },
                )),
          ]),
        ));
  }
}
