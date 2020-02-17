import 'dart:io';
import 'package:ble_client_app/models/DataModel.dart';
import 'package:ble_client_app/utils/StringUtils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {

  static const int CURRENT_DB_VERSION = 1;

  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  DatabaseProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_NAME);
    return await openDatabase(path, version: CURRENT_DB_VERSION,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(CREATE_TABLE_QUERY);
        });
  }

  Future insertSensorData(DataModel dataModel) async {
    final db = await database;
    db.insert(TABLE_NAME, dataModel.toMap());
  }

  Future<List<Map<String, dynamic>>> getDataByDateRange(int from, int to) async {
    final db = await database;
    String query = "SELECT * FROM $TABLE_NAME "
                   "WHERE $TIME_STAMP >= $from and $TIME_STAMP <= $to";
    print(query);
    return await db.rawQuery(query);
  }

  Future<List<Map<String, dynamic>>> getLastNRows(int n) async {
    final db = await database;
    String query = "SELECT * FROM $TABLE_NAME ORDER BY $ROW_ID DESC LIMIT $n";
    print(query);
    return await db.rawQuery(query);
  }

  Future<List<Map<String, dynamic>>> getDailyStatsByDeviceName(int from, int to, String deviceName) async {
    final db = await database;
    String query = "SELECT avg($PH) AS average, min($PH) AS min, max($PH) AS max "
                   "FROM $TABLE_NAME "
                   "WHERE $TIME_STAMP >= $from and $TIME_STAMP <= $to "
                      "and $DEVICE_ID = '$deviceName'";
    print(query);
    return await db.rawQuery(query);
  }
}
