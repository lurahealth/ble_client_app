import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class StringUtils{

  // Database Strings
  static final String DATABASE_NAME = "SensorData.db";
  static final String TABLE_NAME = "Data_Table";

  // columns names
  static final String ROW_ID = "row_id"; // Primary key, auto-incremented
  static final String PH = "ph"; // pH reading
  static final String BATTERY = "battery"; // battery voltage reading
  static final String TEMPERATURE = "temperature"; // temperature reading
  static final String CONNETION_TIME = "connection_time"; // time to connect to the sensor
  static final String TIME_STAMP = "time_stamp"; // time stamp of the reading in UTC
  static final String NOTES = "notes"; // Note for a sensor reading
  static final String DEVICE_ID = "device_id"; // Device sending the data
  static final String UPLOADED = "uploaded"; // if sensor data has been uploaded set to 1 else set to 0

  static final String CREATE_TABLE_QUERY =
      "CREATE TABLE $TABLE_NAME ("
      "$ROW_ID INTEGER PRIMARY KEY,"
      "$DEVICE_ID TEXT,"
      "$UPLOADED REAL,"
      "$PH REAL,"
      "$BATTERY REAL,"
      "$TEMPERATURE REAL,"
      "$CONNETION_TIME INTEGER,"
      "$NOTES TEXT,"
      "$TIME_STAMP INTEGER)";

  // UUID
  static final String UART_SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  static final String RX_UUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";

  // Time format
  static final DateFormat dataTableTimeFormat = DateFormat("HH:mm:ss");
  static final DateFormat csvDateTimeFormat = DateFormat("dd.MMMM.yyyy HH:mm");

  //Style
  static final TextStyle style = TextStyle(fontSize: 15);
}