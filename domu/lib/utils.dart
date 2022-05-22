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
  }
}
