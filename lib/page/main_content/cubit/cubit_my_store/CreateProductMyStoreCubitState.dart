import 'package:equatable/equatable.dart';

abstract class CreateProductMyStoreCubitState extends Equatable {
  const CreateProductMyStoreCubitState();

  @override
  List<Object> get props => [];
}

class InitialStateCreateProductMyStoreCubitState
    extends CreateProductMyStoreCubitState {}

class LoadingCreateProductMyStoreCubitState
    extends CreateProductMyStoreCubitState {}

class StateLoadDataProduct extends CreateProductMyStoreCubitState {}
//
// class LoadProfileSukses extends CreateProductMyStoreCubitState {
//   PayloadResponseMyProfileCreateProduct? data = null;
//
//   LoadProfileSukses({this.data});
// }
//
// class LoadDataPribadiSukses extends CreateProductMyStoreCubitState {
//   PayloadResponseProfile? data = null;
//   int indexMenu = -1;
//   LoadDataPribadiSukses({this.data, required this.indexMenu});
// }
//
// class GoTo extends CreateProductMyStoreCubitState {
//   String goTo;
//
//   GoTo(this.goTo);
// }
