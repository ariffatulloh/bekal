import 'package:bekal/page/auth/cubit/splash_screen/SplashCubit.dart';
import 'package:bekal/page/controll_all_page/cubit/controller_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext cubitContext) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
      child: Scaffold(
        body: BlocBuilder<SplashCubit, SplashCubitState>(
            builder: (cubitContext, cubitState) {
          cubitContext.read<SplashCubit>().CheckingToken();
          // if (cubitState is Loading) {
          //   return Container(
          //     height: MediaQuery.of(cubitContext).size.height,
          //     width: MediaQuery.of(cubitContext).size.width,
          //     padding: EdgeInsets.all(5),
          //     color: Color.fromRGBO(243, 146, 0, 1),
          //     child: Stack(
          //       children: [
          //         Align(
          //           alignment: Alignment.center,
          //           child: Lottie.network(
          //               'https://assets8.lottiefiles.com/packages/lf20_jtzgxdui.json',
          //               width: MediaQuery.of(cubitContext).size.width * .7
          //               // artboard: 'Truck',
          //               ),
          //         ),
          //         Align(
          //           alignment: Alignment.bottomCenter,
          //           child: Image.asset(
          //             "assets/logokabel.png",
          //             height: 90,
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // } else
          if (cubitState is GoTo) {
            // Future.delayed(const Duration(seconds: 10), () {
            //
            cubitContext.read<ControllerPageCubit>().goto(cubitState.goTo);

            // });

            return Container();
          } else {
            return Container(
              height: MediaQuery.of(cubitContext).size.height,
              width: MediaQuery.of(cubitContext).size.width,
              padding: EdgeInsets.all(5),
              color: Colors.black12,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    // child: Lottie.asset('assets/splash2.json', width: 80.w
                    //     // artboard: 'Truck',
                    //     ),
                    child: Lottie.network(
                        'https://assets8.lottiefiles.com/packages/lf20_jtzgxdui.json',
                        width: MediaQuery.of(cubitContext).size.width * .7
                        // artboard: 'Truck',
                        ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/logokabelv2.png",
                      height: 90,
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
