part of 'VerificationCubit.dart';

abstract class VerificationCubitState extends Equatable {
  const VerificationCubitState();

  @override
  List<Object> get props => [];
}

class InitialVerificationState extends VerificationCubitState {}

class LOADING extends VerificationCubitState {}

class GotoHome extends VerificationCubitState {}

class SUKSES_RESEND_CODE extends VerificationCubitState {
  String? message = "";

  SUKSES_RESEND_CODE({this.message});
}

class FAILED_RESEND_CODE extends VerificationCubitState {
  String? message = "";

  FAILED_RESEND_CODE({this.message});
}
