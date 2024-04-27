// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//   }
//
//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('==============FCM Token==============: $fCMToken');
//     FirebaseMessaging.onBackgroundMessage(handleBgMsg);
//   }
//
//   Future initPushNotifications() async {
//     FirebaseMessaging.instance.getInitialMessage().then(handleBgMsg);
//   }
// }
