import 'dart:ffi';

import 'package:domu/screens/homeCoach.dart';
import 'package:domu/screens/createCoachClassroom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:domu/screens/homeStudent.dart';
import 'package:domu/screens/studentJoinClassroom.dart';
import 'package:flutter/material.dart';
import '../globalVars.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/labeledCheckbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

Future<Map<String, dynamic>?> getUserDataByID(String? uid) async {
  if (globals.user != null) {
    // CollectionReference classrooms =
    //     FirebaseFirestore.instance.collection('classrooms');

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        return null;
      }
    });
  } else {
    return null;
  }
}

Future<Map<String, int>?> getTimeMap() async {
  Map<String, int> timeMap = <String, int>{};
  String workoutName = "";
  String classCode = "";

  await FirebaseFirestore.instance
      .collection('users')
      .doc(globals.user?.uid)
      .get()
      .then((documentSnapshot) {
    var data = documentSnapshot.data();
    //debugPrint("Firebase");
    if (data != null && data.containsKey("classroomCode")) {
      classCode = data["classroomCode"];
    }
  });

  await FirebaseFirestore.instance
      .collection('classrooms')
      .where('classroomCode', isEqualTo: classCode)
      .get()
      .then((querySnapshot) {
    //debugPrint("QuerySnap length: ${querySnapshot.docs.length}");
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      //debugPrint("Firebase");
      if (data.containsKey("workoutName")) {
        workoutName = data["workoutName"];
      }
    }
  });

  await FirebaseFirestore.instance
      .collection('workouts')
      .where('name', isEqualTo: workoutName)
      .get()
      .then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      //debugPrint("Firebase");
      timeMap = Map<String, int>.from(data["timeMap"]);
    }
  });

  print(timeMap);
  return timeMap;
}

Future<Map<String, String>?> getWorkoutMap() async {
  Map<String, String> exerciseMap = <String, String>{};
  String workoutName = "";
  String classCode = "";

  await FirebaseFirestore.instance
      .collection('users')
      .doc(globals.user?.uid)
      .get()
      .then((documentSnapshot) {
    var data = documentSnapshot.data();
    //debugPrint("Firebase");
    if (data != null && data.containsKey("classroomCode")) {
      classCode = data["classroomCode"];
    }
  });

  await FirebaseFirestore.instance
      .collection('classrooms')
      .where('classroomCode', isEqualTo: classCode)
      .get()
      .then((querySnapshot) {
    //debugPrint("QuerySnap length: ${querySnapshot.docs.length}");
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      //debugPrint("Firebase");
      if (data.containsKey("workoutName")) {
        workoutName = data["workoutName"];
      }
    }
  });

  await FirebaseFirestore.instance
      .collection('workouts')
      .where('name', isEqualTo: workoutName)
      .get()
      .then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      //debugPrint("Firebase");
      exerciseMap = Map<String, String>.from(data["exerciseMap"]);
    }
  });

  return exerciseMap;
}

Future<List<String>> getCoachExercises(var workoutName) async {
  Map<String, String> exerciseMap = <String, String>{};
  List<String> workoutNames = [];

  await FirebaseFirestore.instance
      .collection('workouts')
      .where('name', isEqualTo: workoutName)
      .get()
      .then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      //debugPrint("Firebase");
      exerciseMap = Map<String, String>.from(data["exerciseMap"]);
      exerciseMap.forEach((k, v) => workoutNames.add(k));
    }
  });

  return workoutNames;
}

Future<String> getWorkoutName() async {
  var workoutName = "";
  var classCode = "";

  await FirebaseFirestore.instance
      .collection('users')
      .doc(globals.user?.uid)
      .get()
      .then((documentSnapshot) {
    var data = documentSnapshot.data();
    //debugPrint("Firebase");
    if (data != null && data.containsKey("classroomCode")) {
      classCode = data["classroomCode"];
    }
  });

  await FirebaseFirestore.instance
      .collection('classrooms')
      .where('classroomCode', isEqualTo: classCode)
      .get()
      .then((querySnapshot) {
    //debugPrint("QuerySnap length: ${querySnapshot.docs.length}");
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      //debugPrint("Firebase");
      if (data.containsKey("workoutName")) {
        workoutName = data["workoutName"];
      }
    }
  });

  return workoutName;
}

Future addPoints() async {
  var uid = globals.user?.uid;
  var currentPoints = 0;

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if(documentSnapshot.data()!.containsKey('points')){
      currentPoints = documentSnapshot.data()?['points'];
    }
  });

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update({'points': (currentPoints + 5000)}).then((val) {
    print("Updated Points");
  });

}
