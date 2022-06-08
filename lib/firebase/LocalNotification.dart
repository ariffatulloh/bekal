import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LocalNotificationPlugin {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings get initializationSettingsAndroid {
    return AndroidInitializationSettings('@drawable/ic_stat_logokabelv2');
  }

  static IOSInitializationSettings get initializationSettingsIOS {
    return IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) {});
  }

  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );
  InitializationSettings get initializationSettings {
    return InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
  }

  Future<void> _createNotificationChannel(
      {required BuildContext context}) async {
    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      'your channel id 2',
      'your channel name 2',
      description: 'your channel description 2',
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    await showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content:
                  Text('Channel with name ${androidNotificationChannel.name} '
                      'created'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  Future initialIze(
      {required Function(String? Payload) onSelectedNotification}) async {
    var notificationAppLaunchDetails =
        // await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
        // String initialRoute = HomePage.routeName;
        // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        //   selectedNotificationPayload = notificationAppLaunchDetails!.payload;
        //   initialRoute = SecondPage.routeName;
        // }
        await flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: (String? payload) async {
      onSelectedNotification(payload);
    });
    // const String channelGroupId = 'your channel group id';
    // // create the group first
    // const AndroidNotificationChannelGroup androidNotificationChannelGroup =
    //     AndroidNotificationChannelGroup(
    //         channelGroupId, 'your channel group name',
    //         description: 'your channel group description');
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()!
    //     .createNotificationChannelGroup(androidNotificationChannelGroup);
    //
    // // create channels associated with the group
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()!
    //     .createNotificationChannel(const AndroidNotificationChannel(
    //         'grouped channel id 1', 'grouped channel name 1',
    //         description: 'grouped channel description 1',
    //         groupId: channelGroupId));
    //
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()!
    //     .createNotificationChannel(const AndroidNotificationChannel(
    //         'grouped channel id 2', 'grouped channel name 2',
    //         description: 'grouped channel description 2',
    //         groupId: channelGroupId));

    _requestPermissions();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future showNotif(
      {required int id,
      String? title = "",
      String? message = "",
      String? payload}) {
    print("initiate");
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
