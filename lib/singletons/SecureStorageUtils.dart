import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

Future writeToSecureStorage(String key, String value) async {
  await _flutterSecureStorage.write(key: key, value: value);
}

Future<String> readFromSecureStorage(String key) async {
  return await _flutterSecureStorage.read(key: key);
}

Future deleteFromSecureStorage(String key) async {
  await _flutterSecureStorage.delete(key: key);
}

Future<void> saveUserNameAndPassword(String userName, String password) async {
  
  await deleteFromSecureStorage(SAVED_USER_EMAIL);
  await deleteFromSecureStorage(SAVED_PASSWORD);
  
  await writeToSecureStorage(SAVED_USER_EMAIL, userName);
  await writeToSecureStorage(SAVED_PASSWORD, password);
}

//saveBLEDeviceName(String deviceName) async {
//  await deleteFromSecureStorage(SAVED_BLE_DEVICE_NAME);
//  await writeToSecureStorage(SAVED_BLE_DEVICE_NAME, deviceName);
//}
//
//Future<String> getSavedDeviceName() async {
//  return await readFromSecureStorage(SAVED_BLE_DEVICE_NAME);
//}
