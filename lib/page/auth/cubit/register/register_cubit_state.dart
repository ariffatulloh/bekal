import 'package:equatable/equatable.dart';

abstract class RegisterCubitState extends Equatable {
  RegisterCubitState();

  @override
  List<Object> get props => [];
}

class InitialRegisterState extends RegisterCubitState {}

class LOADING extends RegisterCubitState {}

class REGISTER_FAILED extends RegisterCubitState {
  String? Message = "";

  REGISTER_FAILED({this.Message});
}

class GotoVerifiedAccount extends RegisterCubitState {}

class GotoHome extends RegisterCubitState {}

class GOTO_LOGIN extends RegisterCubitState {}
