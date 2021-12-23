part of 'SplashCubit.dart';

class SplashCubitState extends Equatable {
  const SplashCubitState();

  @override
  List<Object> get props => [];
}

class CheckingTokenState extends SplashCubitState {}

class Loading extends SplashCubitState {}

class GoTo extends SplashCubitState {
  String goTo;

  GoTo(this.goTo);
}
