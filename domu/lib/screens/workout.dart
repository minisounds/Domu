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
  String imageString =
      "https://cdn.cloudflare.steamstatic.com/steam/apps/945360/capsule_616x353.jpg?t=1646296970";

  CollectionReference workouts =
      FirebaseFirestore.instance.collection('workouts');

  void getWorkoutImage() {
    var newImageString = "";

    FutureBuilder<DocumentSnapshot>(
      future: workouts.doc("5BawjBh258iKMcgi5wPm").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        debugPrint("builder");
        if (snapshot.hasError) {
          debugPrint("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          debugPrint("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          debugPrint(data['images'][index]);
          newImageString = data['images'][index];
        }

        return const Text("loading");
      },
    );

    setState(() {
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
      imageString = newImageString;
      index = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Column(children: [
          Container(
            child: const Text("Exercise:"),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
          ),
          Container(
            child: Image.network(imageString),
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
              onPressed: getWorkoutImage,
            ),
            padding: const EdgeInsets.all(5.0),
          )
        ]));
  }
}
