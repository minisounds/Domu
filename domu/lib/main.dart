import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'firebase_options.dart';
import 'package:domu/screens/homeStudent.dart';
import 'screens/homeCoach.dart';
import './screens/workout.dart';
import './screens/signup.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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