import 'package:equatable/equatable.dart';

class ControllerPageCubitState extends Equatable {
  const ControllerPageCubitState();

  @override
  List<Object> get props => [];
}

class InitialSplashScreen extends ControllerPageCubitState {}

class Goto extends ControllerPageCubitState {
  String goto;

  Goto(this.goto);
}

class LOGIN extends ControllerPageCubitState {}

class SPLASH extends ControllerPageCubitState {}

class VERIFIEDACCOUNT extends ControllerPageCubitState {}

class REGISTER extends ControllerPageCubitState {}

class HOME extends ControllerPageCubitState {}
