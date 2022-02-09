import 'package:bekal/payload/response/PayloadResponseProfile.dart';
import 'package:bekal/payload/response/PayloadResponseUpdatePersonalInformation.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileScreenDataPribadiCubitState extends Equatable {
  const ProfileScreenDataPribadiCubitState();

  @override
  List<Object> get props => [];
}

class InitialDataPribadiState extends ProfileScreenDataPribadiCubitState {}

class LoadingDataPribadi extends ProfileScreenDataPribadiCubitState {}

class LoadDataPribadiStateSukses extends ProfileScreenDataPribadiCubitState {
  PayloadResponseProfile? data = null;

  LoadDataPribadiStateSukses({this.data});
}

class UpdateDataPribadiSukses extends ProfileScreenDataPribadiCubitState {
  PayloadResponseUpdatePersonalInformation? data = null;

  UpdateDataPribadiSukses({this.data});
}

class GoToDataPribadiState extends ProfileScreenDataPribadiCubitState {
  String goTo;
  String? message;

  GoToDataPribadiState(this.goTo, {this.message});
}
