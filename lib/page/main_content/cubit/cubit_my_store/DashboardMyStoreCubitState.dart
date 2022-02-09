import 'package:equatable/equatable.dart';

abstract class DashboardMyStoreCubitState extends Equatable {
  const DashboardMyStoreCubitState();

  @override
  List<Object> get props => [];
}

class InitialStateDashboardMyStoreCubitState
    extends DashboardMyStoreCubitState {}

class LoadingDashboardMyStoreCubitState extends DashboardMyStoreCubitState {}

class StateLoadDataProduct extends DashboardMyStoreCubitState {}
//
// class LoadProfileSukses extends DashboardMyStoreCubitState {
//   PayloadResponseMyProfileDashboard? data = null;
//
//   LoadProfileSukses({this.data});
// }
//
// class LoadDataPribadiSukses extends DashboardMyStoreCubitState {
//   PayloadResponseProfile? data = null;
//   int indexMenu = -1;
//   LoadDataPribadiSukses({this.data, required this.indexMenu});
// }
//
// class GoTo extends DashboardMyStoreCubitState {
//   String goTo;
//
//   GoTo(this.goTo);
// }
