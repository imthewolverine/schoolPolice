// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCX4ja9XSeTTlsV-iODdRQ0hP5_0w_51wY',
    appId: '1:491759785783:web:b2570babe13001f750ecb2',
    messagingSenderId: '491759785783',
    projectId: 'school-police-c59de',
    authDomain: 'school-police-c59de.firebaseapp.com',
    storageBucket: 'school-police-c59de.firebasestorage.app',
    measurementId: 'G-WMM4R4WQBC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDppydc63T6fuOM4x7-KZsU_3r6QA391M',
    appId: '1:491759785783:android:4fb637db5a2dc5c750ecb2',
    messagingSenderId: '491759785783',
    projectId: 'school-police-c59de',
    storageBucket: 'school-police-c59de.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCX4ja9XSeTTlsV-iODdRQ0hP5_0w_51wY',
    appId: '1:491759785783:web:b88debae9149c66f50ecb2',
    messagingSenderId: '491759785783',
    projectId: 'school-police-c59de',
    authDomain: 'school-police-c59de.firebaseapp.com',
    storageBucket: 'school-police-c59de.firebasestorage.app',
    measurementId: 'G-JQJ9Y628XQ',
  );
}
