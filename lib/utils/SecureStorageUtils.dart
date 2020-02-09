import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

writeToSecureStorage(String key, String value) async {
  await new FlutterSecureStorage().write(key: key, value: value);
}

Future<String> readFromSecureStorage(String key) async {
  return await new FlutterSecureStorage().read(key: key);
}

deleteFromSecureStorage(String key) async {
  await new FlutterSecureStorage().delete(key: key);
}

saveBLEDeviceName(String deviceName) async {
  await deleteFromSecureStorage(StringUtils.BLE_DEVICE_NAME);
  await writeToSecureStorage(StringUtils.BLE_DEVICE_NAME, deviceName);
}
