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

Future<Map<String, String>?> getWorkoutMap() async {
  Map<String, String> exerciseMap = <String, String>{};
  String workoutName = "";
  var classroomCode = "";

  await FirebaseFirestore.instance
      .collection('users')
      .doc(globals.user?.uid)
      .get()
      .then((documentSnapshot) {
    var data = documentSnapshot.data();
    debugPrint("Firebase");
    classroomCode = data?["classroom_codes"][0];
  });

  await FirebaseFirestore.instance
      .collection('workouts')
      .where('classroomCode', isEqualTo: classroomCode)
      .get()
      .then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      debugPrint("Firebase");
      workoutName = data["workoutName"];
    }
  });

  await FirebaseFirestore.instance
      .collection('workouts')
      .where('name', isEqualTo: workoutName)
      .get()
      .then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      debugPrint("Firebase");
      var exerciseMap = data["exerciseMap"];
      return exerciseMap;
    }
  });
  return exerciseMap;
}
