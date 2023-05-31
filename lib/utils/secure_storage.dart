import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyUserName = 'username';
  static const _keyPassword = 'password';

  static Future setUsername(String userName) async {
    await _storage.write(key: _keyUserName, value: userName);
  }

  static Future setPassword(String password) async {
    await _storage.write(key: _keyPassword, value: password);
  }

  static Future<String?> getUsername() async {
    String? userName = await _storage.read(key: _keyUserName);
    return userName;
  }

  static Future<String?> getPassword() async {
    String? password = await _storage.read(key: _keyPassword);
    return password;
  }

  static void deleteAll() async {
    await _storage.deleteAll();
  }
}
