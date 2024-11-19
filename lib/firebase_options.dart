import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'iOS is not supported - configure iOS app separately',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCG1huU1n3FNNZe7-JRc2ytQmY4pUsu8c',
    appId: '1:260515434120:web:eb0de20a95a1cef299993d',
    messagingSenderId: '260515434120',
    projectId: 'finalyoga-f8d29',
    authDomain: 'finalyoga-f8d29.firebaseapp.com',
    databaseURL:
        'https://finalyoga-f8d29-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'finalyoga-f8d29.firebasestorage.app',
    measurementId: 'G-XRSWVRMCQE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGVQU2u-zza1IeeNucjlL_zRLnTTNJ98A',
    appId: '1:260515434120:android:10c63c51de5f76e699993d',
    messagingSenderId: '260515434120',
    projectId: 'finalyoga-f8d29',
    databaseURL:
        'https://finalyoga-f8d29-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'finalyoga-f8d29.firebasestorage.app',
  );
}
