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
    apiKey: 'AIzaSyCHsSS8nq_FY0RzvA5NVjaYvtcAVzErRCg',
    appId: '1:458350460274:web:3f9523dfe59fa8967b71eb',
    messagingSenderId: '458350460274',
    projectId: 'initial-teleo',
    authDomain: 'initial-teleo.firebaseapp.com',
    storageBucket: 'initial-teleo.firebasestorage.app',
    measurementId: 'G-EKDNNHS2S9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_d8B67eZyh6iXoZj9wPI7S6MNAqGGNmM',
    appId: '1:458350460274:android:9bc10673caf13d7d7b71eb',
    messagingSenderId: '458350460274',
    projectId: 'initial-teleo',
    storageBucket: 'initial-teleo.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaXoafqv73N8-I0_jd60JsRf_D_WgG69c',
    appId: '1:458350460274:ios:42ed232f274a662e7b71eb',
    messagingSenderId: '458350460274',
    projectId: 'initial-teleo',
    storageBucket: 'initial-teleo.firebasestorage.app',
    iosClientId: '458350460274-fkpc65lke259k1nspa05uqcdj0nm50v6.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAaXoafqv73N8-I0_jd60JsRf_D_WgG69c',
    appId: '1:458350460274:ios:42ed232f274a662e7b71eb',
    messagingSenderId: '458350460274',
    projectId: 'initial-teleo',
    storageBucket: 'initial-teleo.firebasestorage.app',
    iosClientId: '458350460274-fkpc65lke259k1nspa05uqcdj0nm50v6.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCHsSS8nq_FY0RzvA5NVjaYvtcAVzErRCg',
    appId: '1:458350460274:web:93aa925fee999d4c7b71eb',
    messagingSenderId: '458350460274',
    projectId: 'initial-teleo',
    authDomain: 'initial-teleo.firebaseapp.com',
    storageBucket: 'initial-teleo.firebasestorage.app',
    measurementId: 'G-6N6ZYB9ESL',
  );
}
