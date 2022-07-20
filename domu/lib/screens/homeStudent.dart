import 'package:domu/screens/workout.dart';
import 'package:domu/utils.dart';
import 'package:flutter/material.dart';
import 'package:domu/screens/signup.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import './prepareForWorkout.dart';
import '../utils.dart';

class HomeStudentScreen extends StatefulWidget {
  const HomeStudentScreen({Key? key}) : super(key: key);

  @override
  _HomeStudentScreenState createState() => _HomeStudentScreenState();
}

class _HomeStudentScreenState extends State<HomeStudentScreen> {
  Map<String, String> workoutMap = <String, String>{};
  final Uri _url = Uri.parse(
      'https://docs.google.com/forms/d/e/1FAIpQLSeSY4Kb-gEg5EHLZ-wgnW2s_7NGH9B-6MPDW1HBoEpb0kDdPQ/viewform');
  var workoutNames = [];
  List<Widget> workoutRows = [];
  final ScrollController _scrollController = ScrollController();

  _HomeStudentScreenState() {
    getExercises();
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  void getExercises() async {
    workoutMap = (await getWorkoutMap())!;
    for (var exerciseName in workoutMap.keys) {
      workoutNames.add(exerciseName);
    }
    setState(() {
      workoutNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Domú",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   padding: const EdgeInsets.all(20),
            //   child: const Text(
            //     "Class Leaderboard",
            //     style: TextStyle(fontSize: 30),
            //   ),
            // ),
            // Column(
            //   children: [
            //     Card(
            //       child: ListTile(
            //         contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
            //         leading: const Icon(Icons.account_circle,
            //             color: Colors.yellow, size: 35.0),
            //         title: const Text("Ariana"),
            //         subtitle: const Text("16,000 Points"),
            //         trailing: Container(
            //           padding: const EdgeInsets.all(20),
            //           child: const Icon(
            //             Icons.emoji_events,
            //             color: Colors.yellow,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Card(
            //       child: ListTile(
            //         contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
            //         leading: const Icon(Icons.account_circle,
            //             color: Colors.grey, size: 35.0),
            //         title: const Text("Bobert"),
            //         subtitle: const Text("15,000 Points"),
            //         trailing: Container(
            //           padding: const EdgeInsets.all(20),
            //           child: const Icon(
            //             Icons.military_tech,
            //             color: Colors.grey,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Card(
            //       child: ListTile(
            //         contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
            //         leading: const Icon(Icons.account_circle,
            //             color: Colors.brown, size: 35.0),
            //         title: const Text("Edwardo"),
            //         subtitle: const Text("14,560 Points"),
            //         trailing: Container(
            //           padding: const EdgeInsets.all(20),
            //           child: const Icon(
            //             Icons.military_tech,
            //             color: Colors.brown,
            //           ),
            //         ),
            //       ),
            //     ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text("This Week's Workout: ",
                          style: TextStyle(fontSize: 30))),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 200, //minimum height
                      minWidth: 300, // minimum width

                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                      //maximum height set to 100% of vertical height

                      maxWidth: MediaQuery.of(context).size.width,
                      //maximum width set to 100% of width
                    ),
                    child: Scrollbar(
                      controller: _scrollController,
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              for (String name in workoutNames)
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 10, 20),
                                  child: ListTile(
                                    leading: const Icon(Icons.star_border,
                                        color: Colors.yellow),
                                    title: Text(name),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PrepareForWorkoutScreen()),
                          );
                        },
                        child: const Text("START WORKOUT")),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "Predicted Workout Time: 10 minutes",
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "Important: before getting started, find an open spot outside, with a racquet and tennis ball.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: ElevatedButton(
                        onPressed: _launchUrl,
                        child: const Text("Give Us Feedback on the App Here!")),
                  )
                ],
              ),
            ),
          ],
        ),
        // ],
      ),
      // ),
    );
  }
}
