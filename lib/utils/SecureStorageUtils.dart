import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils{

  static writeToSecureStorage(String key, String value) async {
    await new FlutterSecureStorage().write(key: key, value: value);
  }

  static Future<String> readFromSecureStorage(String key) async {
    return await new FlutterSecureStorage().read(key: key);
  }

  static deleteFromSecureStorage(String key) async {
    await new FlutterSecureStorage().delete(key: key);
  }
}