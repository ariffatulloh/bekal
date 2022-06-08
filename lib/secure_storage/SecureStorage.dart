import 'package:bekal/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage();

  // FlutterSecureStorage _storage = const FlutterSecureStorage();
  static IOSOptions get getIOSOptions =>
      IOSOptions(accessibility: IOSAccessibility.first_unlock);

  static AndroidOptions get getAndroidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<String?> getToken() async {
    return await FlutterSecureStorage().read(
        key: "token", iOptions: getIOSOptions, aOptions: getAndroidOptions);
  }

  Future<String?> getEmail() async {
    return await FlutterSecureStorage().read(
        key: "email", iOptions: getIOSOptions, aOptions: getAndroidOptions);
  }

  Future<String?> getPassword() async {
    return await FlutterSecureStorage().read(
        key: "password", iOptions: getIOSOptions, aOptions: getAndroidOptions);
  }

  Future<String?> getRememberLogin() async {
    return await FlutterSecureStorage().read(
        key: "rememberme",
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
  }

  Future<void> saveTokenWithCredential(
      String token, String email, String password) async {
    await FlutterSecureStorage().write(
        key: "token",
        value: token,
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
    await FlutterSecureStorage().write(
        key: "email",
        value: email,
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
    await FlutterSecureStorage().write(
        key: "password",
        value: password,
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
    await FlutterSecureStorage().write(
        key: "rememberme",
        value: "true",
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
  }

  Future<void> saveTokenOnly(String token) async {
    await FlutterSecureStorage().write(
        key: "token",
        value: token,
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
    await FlutterSecureStorage().write(
        key: "rememberme",
        value: "false",
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
  }

  Future<void> saveSubscribeFirebase(String dataSubscribeFirebase) async {
    await FlutterSecureStorage().write(
        key: "dataSubscribeFirebase",
        value: dataSubscribeFirebase,
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
  }

  Future<String?> getDataSubscribeFirebase() async {
    return await FlutterSecureStorage().read(
        key: "dataSubscribeFirebase",
        iOptions: getIOSOptions,
        aOptions: getAndroidOptions);
  }

  Future<void> deleteStorageToken() async {
    print("deleteStorage");
    return streamSubsUnSubs.add("unsubscribe");

    // CheckingToken();
  }
}
