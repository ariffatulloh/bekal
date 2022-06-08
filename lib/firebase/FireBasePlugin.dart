import 'dart:convert';
import 'dart:io';

import 'package:bekal/firebase/LocalNotification.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FireBasePlugin {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
        authDomain: 'react-native-firebase-testing.firebaseapp.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        projectId: 'react-native-firebase-testing',
        storageBucket: 'react-native-firebase-testing.appspot.com',
        messagingSenderId: '448618578101',
        appId: '1:448618578101:web:772d484dc9eb15e9ac3efc',
        measurementId: 'G-0N1G9FLDZE',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:481453095978:ios:997ba006efd5b40b2e1753',
        apiKey: 'AIzaSyCJkhkJ2z9S4q1jVBc5_swqAbPSYNSnW2Y',
        projectId: 'bekalku-812da',
        messagingSenderId: '481453095978',
        iosBundleId: 'com.belanjakalimantan.bekal',
        iosClientId:
            '481453095978-1ndics8cbqklorjaqts00kj010gc7na2.apps.googleusercontent.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:481453095978:android:315f9e5769b3846a2e1753',
        apiKey: 'AIzaSyDe2uDuF_iUvCSs30iMcfa96F-onYBF-6Q',
        projectId: 'bekalku-812da',
        messagingSenderId: '481453095978',
        androidClientId:
            '481453095978-ppqnq9qukts8kv71ob0289ccevmdrlh1.apps.googleusercontent.com',
      );
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp(options: platformOptions);
    print(
        'Handling a background message ${message.messageId} ::  ${message.data}');
    // await manageIncomingMessage(incomingMessage: message);
  }

  Future<void> initialIze(
      {required Future<void> Function(RemoteMessage message) backgroundHandler,
      int? idUser = -1}) async {
    await Firebase.initializeApp(options: platformOptions);
    // options: const FirebaseOptions(
    //     apiKey: 'AIzaSyDe2uDuF_iUvCSs30iMcfa96F-onYBF-6Q',
    //     appId: '1:481453095978:android:315f9e5769b3846a2e1753',
    //     messagingSenderId: '481453095978',
    //     projectId: 'bekalku-812da'));

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    if (idUser != null) {
      if (idUser != -1) {}
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> manageIncomingMessage(
      {required RemoteMessage incomingMessage}) async {
    print("showNotif");
    if (incomingMessage.data != null) {
      var frameBody = PayloadResponseListConversation.fromJson(
          json.decode(incomingMessage.data['data']));
      print("framebody ===>>> ${frameBody.lastChat}");
      if (frameBody != null) {
        LocalNotificationPlugin().showNotif(
          id: frameBody.hashCode,
          title: frameBody.chatFrom!.fullName,
          message: frameBody.lastChat,
          // payload: 'chat',
          payload: incomingMessage.data['actionTo'],
        );
      }
    }
    var token = await SecureStorage().getToken();
    var email = "";
    if (token != null) {
      PayloadResponseApi<PayloadResponseProfile?> myProfile =
          await ProfileRepository()
              .getProfile(token)
              .catchError((onerror) async {
        return false;
      });
      if (myProfile.errorMessage != null && myProfile.errorMessage.isEmpty) {
        if (myProfile.data != null) {
          email = myProfile.data!.email;
        }
      }
    }
    if (email.isNotEmpty) {
      if (incomingMessage.data != null) {
        var frameBody = PayloadResponseListConversation.fromJson(
            json.decode(incomingMessage.data['data']));
        print("framebody ===>>> ${frameBody.lastChat}");
        if (frameBody != null) {
          LocalNotificationPlugin().showNotif(
            id: frameBody.hashCode,
            title: frameBody.chatFrom!.fullName,
            message: frameBody.lastChat,
            // payload: 'chat',
            payload: incomingMessage.data['actionTo'],
          );
        }
      }
    }
  }
}
