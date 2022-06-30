import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'globalVars.dart' as globals;
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'firebase_options.dart';
import 'package:domu/screens/homeStudent.dart';
import 'screens/homeCoach.dart';
import './screens/workout.dart';
import './screens/signup.dart';
import './screens/signup.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final storageRef = FirebaseStorage.instance.ref();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //auth.signOut();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      print(user);
    }
    globals.user = user;
  });
  downloadImages();
  runApp(const MyApp());
}

void downloadImages() async {
  Map<String, List<String>> workoutMap = <String, List<String>>{};

  await FirebaseFirestore.instance
      .collection("workouts")
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      List<String> tempList = [];
      data["exerciseMap"].keys.forEach((key) => tempList.add(key));
      workoutMap[data["name"]] = tempList;
    }
  });

  for (var name in workoutMap.keys) {
    List<String> workoutSet = workoutMap[name]!;
    for (var workout in workoutSet) {
      var workoutName = "Domu";
      for (var element in workout.split(" ")) {
        workoutName += element;
      }
      var imageRef = storageRef.child("$name/$workoutName.gif");
      var appDocDir = await getApplicationDocumentsDirectory();
      String filePath = "${appDocDir.absolute}/assets/$name/$workoutName";
      File file = File(filePath);

      var downloadTask = imageRef.writeToFile(file);
      downloadTask.snapshotEvents.listen((taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            print("Paused");
            break;
          case TaskState.success:
            print("Success!");
            break;
          case TaskState.canceled:
            print("Canceled");
            break;
          case TaskState.error:
            print("Error");
            break;
        }
      });
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domu Main Screen',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SignUpScreen(),
    );
  }
}
// class _RegisterEmailSection extends StatefulWidget {
//   final String title = 'Registration';
//   @override
//   State<StatefulWidget> createState() => 
//       _RegisterEmailSectionState();
// }
// class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
// @override
//   Widget build(BuildContext context) {
//     //TODO UI content here
//   }
// }