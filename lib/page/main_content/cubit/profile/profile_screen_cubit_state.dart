import 'package:bekal/payload/response/PayloadResponseMyProfileDashboard.dart';
import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileScreenCubitState extends Equatable {
  const ProfileScreenCubitState();

  @override
  List<Object> get props => [];
}

class InitialStateProfileScreenCubitState extends ProfileScreenCubitState {}

class Loading extends ProfileScreenCubitState {}

class LoadProfileSukses extends ProfileScreenCubitState {
  PayloadResponseMyProfileDashboard? data = null;

  LoadProfileSukses({this.data});
}

class LoadDataPribadiSukses extends ProfileScreenCubitState {
  PayloadResponseProfile? data = null;
  int indexMenu = -1;
  LoadDataPribadiSukses({this.data, required this.indexMenu});
}

class GoTo extends ProfileScreenCubitState {
  String goTo;

  GoTo(this.goTo);
}
