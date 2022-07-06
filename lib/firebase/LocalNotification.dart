import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LocalNotificationPlugin {
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  //
  // static AndroidInitializationSettings get initializationSettingsAndroid {
  //   return AndroidInitializationSettings('@drawable/ic_stat_logokabelv2');
  // }
  //
  // late BuildContext _ctx;
  // set ctx(BuildContext context) {
  //   _ctx = context;
  // }
//   static IOSInitializationSettings get initializationSettingsIOS {
//     return IOSInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification: (
//           int id,
//           String? title,
//           String? body,
//           String? payload,
//         ) async {
//           // display a dialog with the notification details, tap ok to go to another page
//           showDialog(
// context: ,
//             builder: (BuildContext context) => CupertinoAlertDialog(
//               title: Text(title ?? ""),
//               content: Text(body ?? ""),
//               actions: [
//                 CupertinoDialogAction(
//                   isDefaultAction: true,
//                   child: Text('Ok'),
//                   onPressed: () async {
//                     // Navigator.of(context, rootNavigator: true).pop();
//                     // await Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => SecondScreen(payload),
//                     //   ),
//                     // );
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }

  // final LinuxInitializationSettings initializationSettingsLinux =
  //     LinuxInitializationSettings(
  //   defaultActionName: 'Open notification',
  //   defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  // );
  // InitializationSettings get initializationSettings {
  //   return InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: IOSInitializationSettings(),
  //   );
  // }

  // Future<void> _createNotificationChannel(
  //     {required BuildContext context}) async {
  //   const AndroidNotificationChannel androidNotificationChannel =
  //       AndroidNotificationChannel(
  //     'your channel id 2',
  //     'your channel name 2',
  //     description: 'your channel description 2',
  //   );
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(androidNotificationChannel);
  //
  //   await showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             content:
  //                 Text('Channel with name ${androidNotificationChannel.name} '
  //                     'created'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           ));
  // }

  // Future initialIze(
  //     {required Function(String? Payload) onSelectedNotification}) async {
  //   var notificationAppLaunchDetails =
  //       // await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  //       // String initialRoute = HomePage.routeName;
  //       // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //       //   selectedNotificationPayload = notificationAppLaunchDetails!.payload;
  //       //   initialRoute = SecondPage.routeName;
  //       // }
  //       await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //           onSelectNotification: (String? payload) async {
  //     onSelectedNotification(payload);
  //   });
  //   // const String channelGroupId = 'your channel group id';
  //   // // create the group first
  //   // const AndroidNotificationChannelGroup androidNotificationChannelGroup =
  //   //     AndroidNotificationChannelGroup(
  //   //         channelGroupId, 'your channel group name',
  //   //         description: 'your channel group description');
  //   // await flutterLocalNotificationsPlugin
  //   //     .resolvePlatformSpecificImplementation<
  //   //         AndroidFlutterLocalNotificationsPlugin>()!
  //   //     .createNotificationChannelGroup(androidNotificationChannelGroup);
  //   //
  //   // // create channels associated with the group
  //   // await flutterLocalNotificationsPlugin
  //   //     .resolvePlatformSpecificImplementation<
  //   //         AndroidFlutterLocalNotificationsPlugin>()!
  //   //     .createNotificationChannel(const AndroidNotificationChannel(
  //   //         'grouped channel id 1', 'grouped channel name 1',
  //   //         description: 'grouped channel description 1',
  //   //         groupId: channelGroupId));
  //   //
  //   // await flutterLocalNotificationsPlugin
  //   //     .resolvePlatformSpecificImplementation<
  //   //         AndroidFlutterLocalNotificationsPlugin>()!
  //   //     .createNotificationChannel(const AndroidNotificationChannel(
  //   //         'grouped channel id 2', 'grouped channel name 2',
  //   //         description: 'grouped channel description 2',
  //   //         groupId: channelGroupId));
  //
  //   _requestPermissions();
  // }
  //
  // void _requestPermissions() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           MacOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  // }

  Future showNotif(
      {required int id,
      String? title = "",
      String? message = "",
      String? payload}) {
    print("initiate");
    var androidInit =
        AndroidInitializationSettings('@drawable/ic_stat_logokabelv2');
    var initiallizationSettingsIOS = IOSInitializationSettings(
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true);
    var initialSetting = new InitializationSettings(
        android: androidInit, iOS: initiallizationSettingsIOS);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initialSetting);

    AndroidNotificationDetails android =
        AndroidNotificationDetails('high_importance_channel', 'Notification',
            channelDescription: 'desc',
            icon: "@drawable/ic_stat_logokabelv2",
            // largeIcon: largeIcon,
            color: Colors.black,
            importance: Importance.max,
            priority: Priority.high);
    IOSNotificationDetails iOS = IOSNotificationDetails();
    NotificationDetails platform =
        NotificationDetails(android: android, iOS: iOS);
    return flutterLocalNotificationsPlugin.show(id, title, message, platform,
        payload: payload);
  }
  // Future<void> get showNotification
}
