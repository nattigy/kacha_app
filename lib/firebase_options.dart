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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA8hETVCdhmYKvWae_A6ciLnl2JX-xiyq0',
    appId: '1:948172562228:web:965d057e02f9881ee08f61',
    messagingSenderId: '948172562228',
    projectId: 'kachaapp-e4fb5',
    authDomain: 'kachaapp-e4fb5.firebaseapp.com',
    storageBucket: 'kachaapp-e4fb5.appspot.com',
    measurementId: 'G-8NE4KEESEL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNuqXnfcH5HfQs3IPNUbkUZfwwVrCzw3A',
    appId: '1:948172562228:android:64cf3cb51562cd86e08f61',
    messagingSenderId: '948172562228',
    projectId: 'kachaapp-e4fb5',
    storageBucket: 'kachaapp-e4fb5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADv2_EFYfrWi3NraSytjzVsQSsBQ27wbE',
    appId: '1:948172562228:ios:c8012a4ac5b048f6e08f61',
    messagingSenderId: '948172562228',
    projectId: 'kachaapp-e4fb5',
    storageBucket: 'kachaapp-e4fb5.appspot.com',
    iosClientId: '948172562228-hi48a0esv9mqg6s7ik6mlqhpurua86sl.apps.googleusercontent.com',
    iosBundleId: 'com.kacha.app.kachaApp',
  );
}