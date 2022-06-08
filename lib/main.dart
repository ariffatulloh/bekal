import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bekal/database/db_locator.dart';
import 'package:bekal/firebase/FireBasePlugin.dart';
import 'package:bekal/firebase/LocalNotification.dart';
import 'package:bekal/page/controll_all_page/ui/page_ui_controll.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
// String token = "";

int? idUser = -1;
// late StompClient stompClient;
// var snapshotListChat = StreamController<
//     List<Map<String, List<PayloadResponseListConversation>>>>.broadcast();
var snapshotListChat = StreamController<int>.broadcast();
var streamNotifChat = StreamController<String?>.broadcast();
var streamToken = StreamController<String?>.broadcast();
var actionToPage = StreamController<String>.broadcast();
String? goto = "";
var streamSubsUnSubs = StreamController<String>.broadcast();

// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: FireBasePlugin.platformOptions,
  );
  var decodeJsonEvent = jsonDecode(message.data["data"]);
  // snapshotListChat.sink.add(message.hashCode);
  LocalNotificationPlugin().showNotif(
      id: message.messageId.hashCode,
      title: decodeJsonEvent["chatFrom"]["userOrStore"] == "user"
          ? "onBackground Dari : ${decodeJsonEvent["chatFrom"]["fullName"]}"
          : "onBackground Dari Toko : ${decodeJsonEvent["chatFrom"]["fullName"]}",
      message: decodeJsonEvent["lastChat"],
      payload: message.data.toString());
}

Future<void> main() async {
  // runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(
    options: FireBasePlugin.platformOptions,
  );

  streamSubsUnSubs.stream.listen((event) async {
    print("$event");
    if (event == "subscribe") {
      var listSubscribeTopic = await SecureStorage().getDataSubscribeFirebase();
      if (listSubscribeTopic != null) {
        var listDataSubs = jsonDecode(listSubscribeTopic);

        Future.forEach(listDataSubs as List<dynamic>, (dynamic element) async {
          print("$event $element");
          await FirebaseMessaging.instance.subscribeToTopic(element);
        });
      }
    }
    if (event == "unsubscribe") {
      var listSubscribeTopic = await SecureStorage().getDataSubscribeFirebase();
      if (listSubscribeTopic != null) {
        var listDataSubs = jsonDecode(listSubscribeTopic);

        Future.forEach(listDataSubs as List<dynamic>, (dynamic element) async {
          print("$event $element");
          await FirebaseMessaging.instance.unsubscribeFromTopic(element);
        });
      }
      await FlutterSecureStorage().deleteAll(
          iOptions: SecureStorage.getIOSOptions,
          aOptions: SecureStorage.getAndroidOptions);
    }
  });
  // await FirebaseMessaging.instance.subscribeToTopic();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    // print('Handling a forground message ${event.data}');
    snapshotListChat.sink.add(event.hashCode);
    var decodeJsonEvent = jsonDecode(event.data["data"]);
    print(decodeJsonEvent);
    LocalNotificationPlugin().showNotif(
        id: event.messageId.hashCode,
        title: decodeJsonEvent["chatFrom"]["userOrStore"] == "user"
            ? "onForground Dari : ${decodeJsonEvent["chatFrom"]["fullName"]}"
            : "onForground Dari Toko : ${decodeJsonEvent["chatFrom"]["fullName"]}",
        message: decodeJsonEvent["lastChat"],
        payload: event.data.toString());
  });

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  if (await askPermission()) {
    BlocOverrides.runZoned(
      () => runApp(RunApps()),
      blocObserver: AppBlocObserver(),
    );
  }
}

Future<bool> askPermission() async {
  var status = await Permission.storage.status;
  var statusManage = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    print('notsave');
    await Permission.storage.request();
  }

  if (!statusManage.isGranted) {
    print('notsave');
    await Permission.manageExternalStorage.request();
  }
  if (Platform.isIOS) {
    var getPermissionPhotos = await Permission.photos.request();
    var getPermissionCamera = await Permission.camera.request();
    if (await getPermissionCamera.isPermanentlyDenied ||
        await getPermissionPhotos.isPermanentlyDenied) {
      await openAppSettings();
    }
    if (await getPermissionPhotos.isGranted &&
        await getPermissionCamera.isGranted) {
      return true;
    } else {
      return false;
    }
  } else {
    return true;
  }
}

/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
