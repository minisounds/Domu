import 'package:flutter/material.dart';
import 'package:domu/screens/coachWorkout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../globalVars.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import '../utils.dart';

class HomeCoachScreen extends StatefulWidget {
  const HomeCoachScreen({Key? key}) : super(key: key);

  @override
  _HomeCoachScreenState createState() => _HomeCoachScreenState();
}

class _HomeCoachScreenState extends State<HomeCoachScreen> {
  final ScrollController _scrollController = ScrollController();
  final Uri _url = Uri.parse(
      'https://docs.google.com/forms/d/e/1FAIpQLSeSY4Kb-gEg5EHLZ-wgnW2s_7NGH9B-6MPDW1HBoEpb0kDdPQ/viewform');
  var workoutNames = [];
  String currentWorkout = "NONE";
  Map<String, String> workoutMap = <String, String>{};

  _HomeCoachScreenState() {
    getExercises();
  }

  void loadChosenWorkoutName() async {
    currentWorkout = await getWorkoutName();
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  Future<String> getWorkoutName() async {
    // String workoutName;
    String classCode = "";
    // first: pull the classroom code from the account
    // second: query the classroom and return the workout name. if the field is empty / doesn't exist, then return: "No Workout Selected Currently"

    await FirebaseFirestore.instance
        .collection('users')
        .doc(globals.user?.uid)
        .get()
        .then((documentSnapshot) {
      var data = documentSnapshot.data();
      print("user data: ");
      print(data);
      if (data != null && data.containsKey("classroomCode")) {
        classCode = data["classroomCode"];
      }
    });
    print("completed classCode fetch");
    await FirebaseFirestore.instance
        .collection('classrooms')
        .where('classroomCode', isEqualTo: classCode)
        .get()
        .then((querySnapshot) {
      //debugPrint("QuerySnap length: ${querySnapshot.docs.length}");
      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        print("in classrooms Firebase call" + data["workoutName"]);
        print("workout name:" + data['workoutName']);
        currentWorkout = data["workoutName"];
        // return (data["workoutName"]);
        //debugPrint("Firebase");
        // if (data.containsKey("workoutName")) {
        //   workoutName = data["workoutName"];
        //   return workoutName;
        // } else {
        //   return "No Workout Selected";
        // }
      }
    });
    print(currentWorkout);
    return currentWorkout;
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
    loadChosenWorkoutName();
    print("currentWorkout:" + currentWorkout);

    print(currentWorkout);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
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
                          Text(
                            "Current Selected Workout: " + currentWorkout,
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CoachWorkoutScreen()),
                                );
                              },
                              child: const Text("Select Workout")),
                          ElevatedButton(
                              onPressed: _launchUrl,
                              child: const Text(
                                  "Give Us Feedback on the App Here!")),
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
