import 'dart:async';
import 'dart:convert';

import 'package:bekal/database/db_locator.dart';
import 'package:bekal/firebase/LocalNotification.dart';
import 'package:bekal/page/controll_all_page/ui/page_ui_controll.dart';
import 'package:bekal/payload/PayloadResponseApi.dart';
import 'package:bekal/payload/response/PayloadResponseListConversation.dart';
import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/repository/chat_repository.dart';
import 'package:bekal/repository/profile_repository.dart';
import 'package:bekal/secure_storage/SecureStorage.dart';
import 'package:bekal/xd_ipro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

// String token = "";

int? idUser = -1;
late StompClient stompClient;
var snapshotListChat = StreamController<
    List<Map<String, List<PayloadResponseListConversation>>>>.broadcast();
var streamNotifChat = StreamController<String?>.broadcast();
var streamToken = StreamController<String?>.broadcast();
var actionToPage = StreamController<String>.broadcast();
String? goto = "";
Future<void> onConnects(StompFrame frame) async {
  print("websocket Connected....");
  var token = (await SecureStorage().getToken()) ?? "";
  var getDataProfile = await ProfileRepository().myProfileDashboard(token);
  PayloadResponseMyProfileDashboard data;
  if (getDataProfile != null) {
    var dataProfile = getDataProfile.data;
    if (dataProfile != null) {
      data = dataProfile;

      List<Map<String, dynamic>> idAccount = [];
      idUser = data.idUser;
      idAccount.add({"id": idUser, "userOrStore": 'user'});
      if (data.myOutlets != null) {
        data.myOutlets!.forEach((element) {
          idAccount.add({"id": element.storeId, "userOrStore": 'store'});
        });
      }
      List<String> subscribeTopics = [];
      idAccount.forEach((element) async {
        subscribeTopics.add('${element['userOrStore']}-${element['id']}');
      });
      // await FireBasePlugin()
      //     .initialIze(backgroundHandler: _firebaseMessagingBackgroundHandler);
      subscribeTopicFirebaseAndStomp(listSubscribeTopic: subscribeTopics);
    }
  }
}

unSubscribeTopicFirebaseAndStomp(
    {required List<String> listSubscribeTopic}) async {
  listSubscribeTopic.forEach((element) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(element);
    print("websocket /topic/message/${element}}");
    subUnSubStomp("");
  });
}

dynamic subUnSubStomp(element) {
  return stompClient.subscribe(
      destination: '/topic/message/${element}',
      callback: (frame) async {
        print("websocket /topic/message/${element}}");
        var token = (await SecureStorage().getToken()) ?? "";
        PayloadResponseApi<PayloadResponseMyProfileDashboard?> getDataProfile =
            await ProfileRepository().myProfileDashboard(token);
        PayloadResponseMyProfileDashboard data;
        if (getDataProfile != null) {
          PayloadResponseMyProfileDashboard dataProfile = getDataProfile.data!;
          if (dataProfile != null) {
            data = dataProfile;
            List<Map<String, dynamic>> idAccount = [];
            idUser = data.idUser;
            idAccount.add({"id": idUser, "userOrStore": 'user'});
            if (data.myOutlets != null) {
              data.myOutlets!.forEach((element) {
                idAccount.add({"id": element.storeId, "userOrStore": 'store'});
              });
            }
            List<Map<String, List<PayloadResponseListConversation>>>
                listToSnapShotChat = [];
            List<String> s = [];
            await Future.forEach(idAccount,
                (Map<String, dynamic> element) async {
              String subscribeTopics =
                  '${element['userOrStore']}-${element['id']}';
              if (element['userOrStore'] == 'user') {
                PayloadResponseApi<List<PayloadResponseListConversation>>
                    getListConversation =
                    await ChatRepository().getListConversation(token);
                var datalist = getListConversation.data;
                s.add("waw");
                if (datalist != null) {
                  listToSnapShotChat.add({'$subscribeTopics': datalist});
                }
              }
              if (element['userOrStore'] == 'store') {
                PayloadResponseApi<List<PayloadResponseListConversation>>
                    getListConversation = await ChatRepository()
                        .getListConversationAsStore(token, element['id']);
                var datalist = getListConversation.data;
                s.add("waw");
                if (datalist != null) {
                  listToSnapShotChat.add({'$subscribeTopics': datalist});
                }
              }
            });

            // print(
            //     'listchat ${listToSnapShotChat.where((element) => element.keys.toString().toLowerCase().contains("user-91")).map((e) => e.values).toList()}');
            // streamNotifChat.sink.add("have new message");

            streamNotifChat.sink.add("have new message");
            snapshotListChat.sink.add(listToSnapShotChat);
          }
        }
      });
}

Future<void> subscribeTopicFirebaseAndStomp(
    {required List<String> listSubscribeTopic}) async {
  await Future.forEach(listSubscribeTopic, (String element) async {
    await FirebaseMessaging.instance.subscribeToTopic(element);
    print("websocket /topic/message/${element}}");
    subUnSubStomp(element);
  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await LocalNotificationPlugin().initialIze(
      onSelectedNotification: (String? payload) {
    print("onSelectedNotification $payload");
    actionToPage.sink.add(payload!);
    goto = payload;
  });
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDe2uDuF_iUvCSs30iMcfa96F-onYBF-6Q',
          appId: '1:481453095978:android:315f9e5769b3846a2e1753',
          messagingSenderId: '481453095978',
          projectId: 'bekalku-812da'));
  print('Handling a background message ${message.messageId} ${message.data}');

  if (message.data != null) {
    var frameBody = PayloadResponseListConversation.fromJson(
        json.decode(message.data['data']));
    print("framebody ===>>> ${frameBody.lastChat}");
    if (frameBody != null) {
      LocalNotificationPlugin().showNotif(
        id: frameBody.hashCode,
        title: frameBody.chatFrom!.fullName,
        message: frameBody.lastChat,
        // payload: 'chat',
        payload: message.data['actionTo'],
      );
    }
  }
}

Future<void> getFromApiAndConfigWebsocket() async {
  var getTokenFromLocal = await SecureStorage().getToken();
  if (getTokenFromLocal != null) {
    var token = getTokenFromLocal;
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://51.79.251.50:3000/ws-message',
        onConnect: onConnects,
        beforeConnect: () async {
          // print('waiting to connect... $token');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error),
        // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
        webSocketConnectHeaders: {'Authorization': token},
      ),
    );
    stompClient.activate();
    // PayloadResponseApi<List<PayloadResponseListConversation>>
    //     getListConversation = await ChatRepository().getListConversation(token);
    // var datalist = getListConversation.data;
    // if (datalist != null) {
    //   snapshotListChat.sink.add(datalist);
    // }
  }
}

// void main() {
//   Locator();
//   BlocOverrides.runZoned(
//     () => runApp(const PageUiControll()),
//     blocObserver: AppBlocObserver(),
//   );
//   // runApp(const PageUiControll());
// }
//
// // class App extends StatelessWidget {
// //   /// {@macro app}
// //   const App({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (_) => ThemeCubit(),
// //       child: const AppView(),
// //     );
// //   }
// // }
//
// class AppBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     if (bloc is Cubit) print(change);
//   }
//
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     print(transition);
//   }
// }
//
// class RunApps extends StatelessWidget {
//   const RunApps({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: "title",
//       home: HomePage(
//         title: "Title",
//       ),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<StatefulWidget> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Future<bool> _onWillPop() async {
//     return (await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Apakah Anda Ingin Keluar?'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: const Text('No'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(true),
//                 child: const Text('Yes'),
//               ),
//             ],
//           ),
//         )) ??
//         false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: PageUiControll(),
//     );
//   }
// }
//
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Sizer(builder: (cubitContext, orientation, deviceType) {
        return XDIpro();
      }),
    );
  }
}

//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

Future<void> main() async {
  // runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  var notifAppLaunch = await LocalNotificationPlugin()
      .flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails();

  if (notifAppLaunch?.didNotificationLaunchApp ?? false) {
    goto = notifAppLaunch!.payload;
    // initialRoute = SecondPage.routeName;
  }
  // await LocalNotificationPlugin().initialIze(
  //     onSelectedNotification: (String? payload) {
  //   print("onSelectedNotification $payload");
  //   actionToPage.sink.add(payload!);
  //   goto = payload;
  // });
  StreamSubscription<String?> streamSubscription =
      streamToken.stream.listen((value) async {
    print('Value from controller: $value');
    print("secured sukses get");
    if (value != null) {}
  });

  // await getFromApiAndConfigWebsocket();

  await setupLocator();
  BlocOverrides.runZoned(
    () => runApp(RunApps()),
    blocObserver: AppBlocObserver(),
  );
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

/// {@template app}
/// A [StatelessWidget] that:
/// * uses [bloc](https://pub.dev/packages/bloc) and
/// [flutter_bloc](https://pub.dev/packages/flutter_bloc)
/// to manage the state of a counter and the app theme.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const AppView(),
    );
  }
}

/// {@template app_view}
/// A [StatelessWidget] that:
/// * reacts to state changes in the [ThemeCubit]
/// and updates the theme of the [MaterialApp].
/// * renders the [CounterPage].
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp(
          theme: theme,
          home: const CounterPage(),
        );
      },
    );
  }
}

/// {@template counter_page}
/// A [StatelessWidget] that:
/// * provides a [CounterBloc] to the [CounterView].
/// {@endtemplate}
class CounterPage extends StatelessWidget {
  /// {@macro counter_page}
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const CounterView(),
    );
  }
}

/// {@template counter_view}
/// A [StatelessWidget] that:
/// * demonstrates how to consume and interact with a [CounterBloc].
/// {@endtemplate}
class CounterView extends StatelessWidget {
  /// {@macro counter_view}
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            return Text('$count', style: Theme.of(context).textTheme.headline1);
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterBloc>().add(Increment()),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterBloc>().add(Decrement()),
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
    );
  }
}

/// Event being processed by [CounterBloc].
abstract class CounterEvent {}

/// Notifies bloc to increment state.
class Increment extends CounterEvent {}

/// Notifies bloc to decrement state.
class Decrement extends CounterEvent {}

/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class CounterBloc extends Bloc<CounterEvent, int> {
  /// {@macro counter_bloc}
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}

/// {@template brightness_cubit}
/// A simple [Cubit] that manages the [ThemeData] as its state.
/// {@endtemplate}
class ThemeCubit extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
