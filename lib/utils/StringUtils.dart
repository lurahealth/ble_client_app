import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';



  // Database Strings
  final String DATABASE_NAME = "SensorData.db";
  final String TABLE_NAME = "Data_Table";

  // columns names
  final String ROW_ID = "row_id"; // Primary key, auto-incremented
  final String PH = "ph"; // pH reading
  final String BATTERY = "battery"; // battery voltage reading
  final String TEMPERATURE = "temperature"; // temperature reading
  final String CONNETION_TIME = "connection_time"; // time to connect to the sensor
  final String TIME_STAMP = "time_stamp"; // time stamp of the reading in UTC
  final String NOTES = "notes"; // Note for a sensor reading
  final String DEVICE_ID = "device_id"; // Device sending the data
  final String UPLOADED = "uploaded"; // if sensor data has been uploaded set to 1 else set to 0

  final String CREATE_TABLE_QUERY =
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
  final String UART_SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  final String RX_UUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";

  // Time format
  final DateFormat dataTableTimeFormat = DateFormat("HH:mm:ss");
  final DateFormat csvDateTimeFormat = DateFormat("dd.MMMM.yyyy HH:mm");

  //Style
  final TextStyle style = TextStyle(fontSize: 15);

  // Secure Storage Keys
  String BLE_DEVICE_NAME = "ble_device_name";
  
  //Routes 
  const BOTTOM_NAVIGATION_SCREEN = "/bottonNavigatinoScreen";
  const DEVICE_SCAN_SCREEN = "/deviceScanScreen";
  const FULL_SCREEN_GRAPH ="/fullScreenGraph";

  //TAGs
  const String PH_GRAPH = "ph_graphs";
