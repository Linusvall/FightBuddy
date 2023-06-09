// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAYGrEeHZhRnlrswjDMOqIS59Ejo3aH_rE',
    appId: '1:651375807362:web:f979e6f0ac6cde61805d9b',
    messagingSenderId: '651375807362',
    projectId: 'fight-buddy',
    authDomain: 'fight-buddy.firebaseapp.com',
    storageBucket: 'fight-buddy.appspot.com',
    measurementId: 'G-ETYYXZVBGY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATyPnhlOjP07QTCC3dfl7rks5pcvWedNc',
    appId: '1:651375807362:android:be52a40effe7d340805d9b',
    messagingSenderId: '651375807362',
    projectId: 'fight-buddy',
    storageBucket: 'fight-buddy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD85hwFnY1Nz3XclYA-orBgKEjJqXcvutY',
    appId: '1:651375807362:ios:b0f8c9a512359afa805d9b',
    messagingSenderId: '651375807362',
    projectId: 'fight-buddy',
    storageBucket: 'fight-buddy.appspot.com',
    iosClientId: '651375807362-hs0o9hk0f4bts6djv0g1g9i76tgk8r9n.apps.googleusercontent.com',
    iosBundleId: 'com.example.fightBuddy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD85hwFnY1Nz3XclYA-orBgKEjJqXcvutY',
    appId: '1:651375807362:ios:b0f8c9a512359afa805d9b',
    messagingSenderId: '651375807362',
    projectId: 'fight-buddy',
    storageBucket: 'fight-buddy.appspot.com',
    iosClientId: '651375807362-hs0o9hk0f4bts6djv0g1g9i76tgk8r9n.apps.googleusercontent.com',
    iosBundleId: 'com.example.fightBuddy',
  );
}
