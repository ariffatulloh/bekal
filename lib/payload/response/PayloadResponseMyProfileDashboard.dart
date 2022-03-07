import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PayloadResponseMyProfileDashboard.freezed.dart';
part 'PayloadResponseMyProfileDashboard.g.dart';

@freezed
class PayloadResponseMyProfileDashboard
    with _$PayloadResponseMyProfileDashboard {
  const factory PayloadResponseMyProfileDashboard({
    String? image,
    int? idUser,
    String? nameUser,
    String? emailUser,
    List<MyDashboardProfileOutlets>? myOutlets,
    Alert? alertUbahDataPribadi,
    Alert? alertHystoryTransaksi,
  }) = _PayloadResponseMyProfileDashboard;

  factory PayloadResponseMyProfileDashboard.fromJson(Object? json) =>
      _$PayloadResponseMyProfileDashboardFromJson(json as Map<String, dynamic>);

// PayloadResponseLogin({this.token = ''});
// factory PayloadResponseLogin.fromJson(Map<String, dynamic> json) =>
//     PayloadResponseLogin(token: json['token'] as String);
//
// Map<String, dynamic> toJson() => <String, dynamic>{'token': this.token};
}
// class PayloadResponseMyProfileDashboard {
//   String? nameuser;
//   String? emailUser;
//   List<MyDashboardProfileOutlets>? myOutlets;
//   Alert? alertUbahDataPribadi;
//   Alert? alertHystoryTransaksi;
//   PayloadResponseMyProfileDashboard({
//     this.nameuser,
//     this.emailUser,
//     this.myOutlets,
//     this.alertUbahDataPribadi,
//     this.alertHystoryTransaksi,
//   });
//   factory PayloadResponseMyProfileDashboard.fromJson(
//           Map<String, dynamic> json) =>
//       _$PayloadResponseMyProfileDashboardFromJson(json);
//   // factory Alert.toJson(Map<String, dynamic> json) => _$Alert(json);
//   // factory PayloadResponseMyProfileDashboard.fromJson(
//   //   Map<String, dynamic> json,
//   //   MyDashboardProfileOutlets Function(Object? json) fromJsonT,
//   // ) {
//   //   return _$PayloadResponseMyProfileDashboardFromJson<
//   //       MyDashboardProfileOutlets>(json, fromJsonT);
//   // }
//   //
//   // Map<String, dynamic> toJson(
//   //   Map<String, dynamic> Function(T value) toJsonT,
//   // ) {
//   //   return _$PayloadResponseApiToJson<T>(this, toJsonT);
//   // }
// }

@JsonSerializable()
class Alert {
  String? message;
  Alert({
    this.message,
  });
  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);
}

@JsonSerializable()
class MyDashboardProfileOutlets {
  String? image;
  String? nameOutlet;
  String? addressOutlet;
  String? detailAddressStore;
  String? phoneNumber;
  String? status;
  int? storeId;
  MyDashboardProfileOutlets({
    this.image,
    this.nameOutlet,
    this.addressOutlet,
    this.detailAddressStore,
    this.phoneNumber,
    this.status,
    this.storeId,
  });
  factory MyDashboardProfileOutlets.fromJson(Map<String, dynamic> json) =>
      _$MyDashboardProfileOutletsFromJson(json);
}
