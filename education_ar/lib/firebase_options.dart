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
    apiKey: 'AIzaSyBdQFcXNPXjB9yPCdtz6OENh8KTOoRjThU',
    appId: '1:565116714964:web:8184cb2b1dfe80bc26e041',
    messagingSenderId: '565116714964',
    projectId: 'education-77e41',
    authDomain: 'education-77e41.firebaseapp.com',
    storageBucket: 'education-77e41.appspot.com',
    measurementId: 'G-P2WPCXEJZG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_2Yw35SjX6bvhHMqq9bUaQmXUtE9qw5A',
    appId: '1:565116714964:android:0fdd777019d9c95726e041',
    messagingSenderId: '565116714964',
    projectId: 'education-77e41',
    storageBucket: 'education-77e41.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqCnRq7oW6xTOf4iDCaNMIGnvj0v9Q72I',
    appId: '1:565116714964:ios:d8b134b56cb270c626e041',
    messagingSenderId: '565116714964',
    projectId: 'education-77e41',
    storageBucket: 'education-77e41.appspot.com',
    iosBundleId: 'com.example.educationAr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqCnRq7oW6xTOf4iDCaNMIGnvj0v9Q72I',
    appId: '1:565116714964:ios:d8b134b56cb270c626e041',
    messagingSenderId: '565116714964',
    projectId: 'education-77e41',
    storageBucket: 'education-77e41.appspot.com',
    iosBundleId: 'com.example.educationAr',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBdQFcXNPXjB9yPCdtz6OENh8KTOoRjThU',
    appId: '1:565116714964:web:b8bb0802bf03574e26e041',
    messagingSenderId: '565116714964',
    projectId: 'education-77e41',
    authDomain: 'education-77e41.firebaseapp.com',
    storageBucket: 'education-77e41.appspot.com',
    measurementId: 'G-7B7RV7DJPH',
  );
}
