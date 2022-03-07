import 'package:bekal/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage();

  // FlutterSecureStorage _storage = const FlutterSecureStorage();
  IOSOptions _getIOSOptions() =>
      IOSOptions(accessibility: IOSAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<String?> getToken() async {
    return await FlutterSecureStorage().read(
        key: "token",
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<String?> getEmail() async {
    return await FlutterSecureStorage().read(
        key: "email",
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<String?> getPassword() async {
    return await FlutterSecureStorage().read(
        key: "password",
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<String?> getRememberLogin() async {
    return await FlutterSecureStorage().read(
        key: "rememberme",
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<void> saveTokenWithCredential(
      String token, String email, String password) async {
    streamToken.sink.add(token);
    await FlutterSecureStorage().write(
        key: "token",
        value: token,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
    await FlutterSecureStorage().write(
        key: "email",
        value: email,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
    await FlutterSecureStorage().write(
        key: "password",
        value: password,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
    await FlutterSecureStorage().write(
        key: "rememberme",
        value: "true",
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<void> saveTokenOnly(String token) async {
    streamToken.sink.add(token);
    await FlutterSecureStorage().write(
        key: "token",
        value: token,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
    await FlutterSecureStorage().write(
        key: "rememberme",
        value: "false",
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<void> deleteStorageToken() async {
    streamToken.sink.add(null);
    await FlutterSecureStorage()
        .deleteAll(iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    // CheckingToken();
  }
}
