import 'package:bekal/page/auth/ui/login/login.dart';
import 'package:bekal/page/auth/ui/register/Register.dart';
import 'package:bekal/page/auth/ui/splash_screen/SplashScreen.dart';
import 'package:bekal/page/auth/ui/verification/VerifikasiScreen.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit_state.dart';
import 'package:bekal/page/main_content/ui/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

class RunApps extends StatelessWidget {
  const RunApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage(
      title: "Title",
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title, this.gotoAnotherPage})
      : super(key: key);

  final String title;
  final String? gotoAnotherPage;
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Apakah Anda Ingin Keluar?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> reLogin() async {
    return (await showDialog(
          context: this.context,
          builder: (context) => AlertDialog(
            title: const Text('Apakah Anda Ingin Keluar?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: PageUiControll(gotoAnotherPage: widget.gotoAnotherPage),
    );
  }
}

class PageUiControll extends StatelessWidget {
  const PageUiControll({Key? key, this.gotoAnotherPage}) : super(key: key);
  final String? gotoAnotherPage;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return BlocProvider<ControllerPageCubit>(
      create: (context) {
        return ControllerPageCubit();
      },
      child: AppView(gotoAnotherPage: gotoAnotherPage),
      // child: Scaffold(
      //   body: BlocBuilder<ControllerPageCubit, ControllerPageCubitState>(
      //     builder: (cubitContext, cubitState) {
      //       return NeumorphicApp(
      //         debugShowCheckedModeBanner: false,
      //         title: 'Flutter Demo',
      //         themeMode: ThemeMode.light,
      //         theme: NeumorphicThemeData(
      //           baseColor: Color(0xFFFFFFFF),
      //           lightSource: LightSource.topLeft,
      //           depth: 10,
      //         ),
      //         darkTheme: NeumorphicThemeData(
      //           baseColor: Color(0xFF3E3E3E),
      //           lightSource: LightSource.topLeft,
      //           depth: 6,
      //         ),
      //         home: Container(
      //           width: 100.w,
      //           height: 100.h,
      //         ),
      //       );
      //       // return Container(
      //       //   height: MediaQuery.of(context).size.height,
      //       //   width: MediaQuery.of(context).size.width,
      //       //   child: Stack(
      //       //     children: [
      //       //       // SplashScreen,
      //       //       gotoPage(cubitState, cubitContext),
      //       //     ],
      //       //   ),
      //       // );
      //       // return Sizer(builder: (cubitContext, orientation, deviceType) {
      //       //   return gotoPage(cubitState, cubitContext);
      //       // });
      //     },
      //   ),
      // ),
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: Container(
    //     child: BlocProvider<ControllerPageCubit>(
    //       create: (context) => ControllerPageCubit(),
    //       child: Scaffold(
    //         body: BlocBuilder<ControllerPageCubit, ControllerPageCubitState>(
    //           builder: (cubitContext, cubitState) {
    //             // return Container(
    //             //   height: MediaQuery.of(context).size.height,
    //             //   width: MediaQuery.of(context).size.width,
    //             //   child: Stack(
    //             //     children: [
    //             //       // SplashScreen,
    //             //       gotoPage(cubitState, cubitContext),
    //             //     ],
    //             //   ),
    //             // );
    //             return Sizer(builder: (cubitContext, orientation, deviceType) {
    //               return gotoPage(cubitState, cubitContext);
    //             });
    //           },
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class AppView extends StatelessWidget {
  final String? gotoAnotherPage;

  /// {@macro app_view}
  const AppView({Key? key, this.gotoAnotherPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControllerPageCubit, ControllerPageCubitState>(
      builder: (cubitContext, cubitState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Sizer(builder: (cubitContext, orientation, deviceType) {
            if (gotoAnotherPage != null) {
              return gotoPageWithoutCubit(gotoAnotherPage!);
            }
            return gotoPage(cubitState, cubitContext);
          }),
        );
      },
    );
  }

  Widget gotoPageWithoutCubit(String gotoAnotherPage) {
    switch (gotoAnotherPage.toUpperCase()) {
      case "LOGIN":
        return Login();
      case "VERIFIED_ACCOUNT":
        return VerifikasiScreen();

      case "HOME":
        return HomeScreen();
      case "REGISTER":
        return Register();
    }
    return HomeScreen();
  }
}

Widget gotoPage(ControllerPageCubitState controllerPageCubitState,
    BuildContext cubitContext) {
  print("ui page controll ${controllerPageCubitState.toString()}");
  if (controllerPageCubitState is LOGIN) {
    return Login();
  } else if (controllerPageCubitState is HOME) {
    return HomeScreen();
  } else if (controllerPageCubitState is SPLASH) {
    return const SplashScreen();
  } else if (controllerPageCubitState is VERIFIEDACCOUNT) {
    return VerifikasiScreen();
  } else if (controllerPageCubitState is REGISTER) {
    return Register();
  } else {
    return Container();
  }
  // switch (controllerPageCubitState.toString()) {
  //   case "LOGIN":
  //     return Login();
  //   case "HOME":
  //     return const HomeScreen();
  //   case "SPLASH":
  //     return const SplashScreen();
  //   case "VERIFIEDACCOUNT":
  //     return VerifikasiScreen();
  //   case "REGISTER":
  //     return Register();
  //   default:
  //     return Container();
  // }
}
