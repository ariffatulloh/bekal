import 'package:equatable/equatable.dart';

abstract class LoginCubitState extends Equatable {
  const LoginCubitState();

  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginCubitState {}
// class CheckingTokenState extends LoginCubitState {}

class FailedLogin extends LoginCubitState {
  String? message = "";

  FailedLogin({this.message});
}

class LOADING extends LoginCubitState {}

class GotoVerifiedAccount extends LoginCubitState {}

class GotoHome extends LoginCubitState {}
