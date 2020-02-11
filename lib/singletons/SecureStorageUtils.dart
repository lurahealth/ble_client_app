import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

writeToSecureStorage(String key, String value) async {
  await _flutterSecureStorage.write(key: key, value: value);
}

Future<String> readFromSecureStorage(String key) async {
  return await _flutterSecureStorage.read(key: key);
}

deleteFromSecureStorage(String key) async {
  await _flutterSecureStorage.delete(key: key);
}

saveBLEDeviceName(String deviceName) async {
  await deleteFromSecureStorage(SAVED_BLE_DEVICE_NAME);
  await writeToSecureStorage(SAVED_BLE_DEVICE_NAME, deviceName);
}

Future<String> getSavedDeviceName() async {
  return await readFromSecureStorage(SAVED_BLE_DEVICE_NAME);
}
