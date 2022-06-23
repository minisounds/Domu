import 'package:flutter/material.dart';
import 'package:domu/screens/coachWorkout.dart';
import '../utils.dart';

class HomeCoachScreen extends StatefulWidget {
  const HomeCoachScreen({Key? key}) : super(key: key);

  @override
  _HomeCoachScreenState createState() => _HomeCoachScreenState();
}

class _HomeCoachScreenState extends State<HomeCoachScreen> {
  final ScrollController _scrollController = ScrollController();
  var workoutNames = [];
  Map<String, String> workoutMap = <String, String>{};

  _HomeCoachScreenState() {
    getExercises();
  }

  void getExercises() async {
    workoutMap = (await getWorkoutMap())!;
    workoutMap.forEach((k, v) => workoutNames.add(k));
    setState(() {
      workoutNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    getExercises();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Domú",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          /*
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Class Leaderboard",
              style: TextStyle(fontSize: 30),
            ),
          ),
          */
          Column(
            children: [
              /*
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                  leading: const Icon(Icons.account_circle,
                      color: Colors.yellow, size: 35.0),
                  title: const Text("Ariana"),
                  subtitle: const Text("16,000 Points"),
                  trailing: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Icon(
                      Icons.emoji_events,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                  leading: const Icon(Icons.account_circle,
                      color: Colors.grey, size: 35.0),
                  title: const Text("Bobert"),
                  subtitle: const Text("15,000 Points"),
                  trailing: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Icon(
                      Icons.military_tech,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                  leading: const Icon(Icons.account_circle,
                      color: Colors.brown, size: 35.0),
                  title: const Text("Edwardo"),
                  subtitle: const Text("14,560 Points"),
                  trailing: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Icon(
                      Icons.military_tech,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
              */
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

                        maxHeight: MediaQuery.of(context).size.height * 0.5,
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
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 10, 20),
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
                       padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CoachWorkoutScreen()),
                                );
                              },
                              child: const Text("Add a Workout")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
