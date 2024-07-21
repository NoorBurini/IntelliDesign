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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyD2XAugVHjEfB96VrLzrzLFS2aJ6w7M4bk',
    appId: '1:490882191861:web:d8eb9414814219ed5550bc',
    messagingSenderId: '490882191861',
    projectId: 'intellidesign-c757d',
    authDomain: 'intellidesign-c757d.firebaseapp.com',
    storageBucket: 'intellidesign-c757d.appspot.com',
    measurementId: 'G-VSHLK2GGM9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpqhi_i4oocBH4g0fNcLkoKOPui92Ke4U',
    appId: '1:490882191861:android:49dac8325f4162235550bc',
    messagingSenderId: '490882191861',
    projectId: 'intellidesign-c757d',
    storageBucket: 'intellidesign-c757d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaaHGK3RGGxjz4jgDhEvo-bPMJGUwdNWk',
    appId: '1:490882191861:ios:9aaff3e2740deb4d5550bc',
    messagingSenderId: '490882191861',
    projectId: 'intellidesign-c757d',
    storageBucket: 'intellidesign-c757d.appspot.com',
    iosBundleId: 'com.example.intellidesign',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaaHGK3RGGxjz4jgDhEvo-bPMJGUwdNWk',
    appId: '1:490882191861:ios:9aaff3e2740deb4d5550bc',
    messagingSenderId: '490882191861',
    projectId: 'intellidesign-c757d',
    storageBucket: 'intellidesign-c757d.appspot.com',
    iosBundleId: 'com.example.intellidesign',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD2XAugVHjEfB96VrLzrzLFS2aJ6w7M4bk',
    appId: '1:490882191861:web:2678c22fee0da0ee5550bc',
    messagingSenderId: '490882191861',
    projectId: 'intellidesign-c757d',
    authDomain: 'intellidesign-c757d.firebaseapp.com',
    storageBucket: 'intellidesign-c757d.appspot.com',
    measurementId: 'G-LG5N4GCSZE',
  );
}
