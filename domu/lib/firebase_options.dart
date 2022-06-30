// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDFu6bwtZqjK2dV-U908Szg77uO6qMSCfI',
    appId: '1:591742475220:web:a581e89d22ee020a2e1441',
    messagingSenderId: '591742475220',
    projectId: 'domu-34f51',
    authDomain: 'domu-34f51.firebaseapp.com',
    storageBucket: 'domu-34f51.appspot.com',
    measurementId: 'G-18T89DFWPW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUpVNpeMEcUJNnsfD52nYZjpCmO2r9e-U',
    appId: '1:591742475220:android:ab6fe94b450ef7872e1441',
    messagingSenderId: '591742475220',
    projectId: 'domu-34f51',
    storageBucket: 'domu-34f51.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVSFNLjzLw1RKAvUYg1mFbeHap6ZcWUcU',
    appId: '1:591742475220:ios:c56403dbc5f0b2752e1441',
    messagingSenderId: '591742475220',
    projectId: 'domu-34f51',
    storageBucket: 'domu-34f51.appspot.com',
    iosClientId: '591742475220-80fr8te9473t6g5darkr7ld7vknet6md.apps.googleusercontent.com',
    iosBundleId: 'com.jamma.domu',
  );
}
