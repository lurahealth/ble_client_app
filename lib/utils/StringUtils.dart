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
final String CONNETION_TIME =
    "connection_time"; // time to connect to the sensor
final String PH_MILLI_VOLT = "ph_milli_volt";
final String TIME_STAMP = "time_stamp"; // time stamp of the reading in UTC
final String NOTES = "notes"; // Note for a sensor reading
final String USER_NAME = "user_name"; // User uploading the data
final String UPLOADED =
    "uploaded"; // if sensor data has been uploaded set to 1 else set to 0

final String CREATE_TABLE_QUERY = "CREATE TABLE $TABLE_NAME ("
    "$ROW_ID INTEGER PRIMARY KEY,"
    "$USER_NAME TEXT,"
    "$UPLOADED REAL,"
    "$PH REAL,"
    "$PH_MILLI_VOLT REAL"
    "$BATTERY REAL,"
    "$TEMPERATURE REAL,"
    "$CONNETION_TIME INTEGER,"
    "$NOTES TEXT,"
    "$TIME_STAMP INTEGER)";


// UUID
final String UART_SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
final String RX_UUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
final String TX_UUID = "6e400002-b5a3-f393-e0a9-e50e24dcca9e";


// Time format
final DateFormat dataTableTimeFormat = DateFormat("HH:mm:ss");
final DateFormat csvDateTimeFormat = DateFormat("dd.MMMM.yyyy HH:mm");

//Style
final TextStyle style = TextStyle(fontSize: 15);

// Secure Storage Keys
const String SAVED_BLE_DEVICE_NAME = "ble_device_name";
const String SAVED_USER_EMAIL = "saved_user_name";
const String SAVED_PASSWORD = "saved_password";


// Calibration Options
const String ONE_POINT_CALIBRATION = "One point calibration";
const String TWO_POINT_CALIBRATION = "Two point calibration";
const String THREE_POINT_CALIBRATION = "Three point calibration";
//Routes
const BOTTOM_NAVIGATION_SCREEN = "/bottonNavigatinoScreen";
const DEVICE_SCAN_SCREEN = "/deviceScanScreen";
const FULL_SCREEN_GRAPH = "/fullScreenGraph";
const LOGIN_SCREEN = "/loginScreen";
const CONFIRM_USER_SCREEN = "/userConfirmScreen";
const NEW_USER_SCREEN = "/newUserScreen";
const CALIBRATION_OPTIONS_SCREEN = "/calibrationOptions";
const CALIBRATION_SCREEN = "/calibrationScreen";

//TAGs
const String PH_GRAPH = "ph_graphs";

// Cognito statuses
const String USER_LOGGED_IN = "user_logged_in";
const String USER_LOGIN_FAILED = "user_login_failed";
const String NEW_PASSWORD_REQUIRED = "New Password required";
const String PASSWORD_CHANGE_SUCCESS = "password_reset_success";
const String PASSWORD_CHANGE_FAILED = "password_reset_failed";
const String PASSWORD_RESET_FAILED = "passowrd_rest_dailed";
const String USER_NOT_CONFIRMED = "User is not confirmed.";
const String INCORRECT_USER_NAME_OR_PASSWORD = "Incorrect username or password";
const String NEW_USER_CREATED = "New user created";

// Password regex
const String PASSWORD_REGEX =
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*-?&^~]{6,}$';

/// ******************************************Screen Text***********************/
// Create New User Screen
const String NEW_USER_SCREEN_NAME_HINT = "Enter your fullname";
const String NEW_USER_SCREEN_NAME_LABEL = "Name";
const String NEW_USER_SCREEN_NAME_ERROR_TEXT = "Name required to create a new patient";
const String NEW_USER_SCREEN_EMAIL_HINT = "Enter your email";
const String NEW_USER_SCREEN_EMAIL_LABEL = "Email";
const String NEW_USER_SCREEN_PASSWORD_HINT = "Enter your password";
const String NEW_USER_SCREEN_PASSWORD_LABEL = "Password";
const String NEW_USER_SCREEN_PASSWORD_ERROR = "Please enter a login password";
const String NEW_USER_SCREEN_CONFIRM_PASSWORD_LABEL = "Confirm password";
const String NEW_USER_SCREEN_CONFIRM_PASSWORD_HINT = "Re-Enter your password";
const String NEW_USER_SCREEN_CONFIRM_PASSWORD_ERROR = "Passwords need to match!";
const String CREATE_NEW_USER_BUTTON = "Create User";

// Login Screen
const String LOGIN_SCREEN_TITLE = "Log In";
const String LOGIN_SCREEN_EMAIL_HINT = "Enter your email";
const String LOGIN_SCREEN_EMAIL_LABEL = "Email";
const String LOGIN_SCREEN_EMAIL_ERROR = "Please enter a valid email address!";
const String LOGIN_SCREEN_PASSWORD_HINT = "Enter your password";
const String LOGIN_SCREEN_PASSWORD_LABEL = "Password";
const String LOGIN_SCREEN_PASSWORD_ERROR =
    "Please enter your password to login!";
const String LOGIN_BUTTON_TEST = "Log in now";
const String LOGIN_LOADING_MESSAGE = "Loggin you in!";
const String NEW_USER_BUTTON_TEXT = "Create new account";

// Reset Password Screen
const String PASSWORD_RESET_SCREEN_TITLE = "Password Reset";
const String PASSWORD_RESET_SCREEN_SUB_TITLE =
    "Your password has expired and needs to be reset";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_LABEL = "New Password";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_HINT =
    "Please enter a new password!";
const String PASSWORD_RESET_SCREEN_NEW_PASSWORD_ERROR =
    "Password need to container atleast \n "
    "1 upper case charecter \n "
    "1 lower case charecter \n "
    "1 number \n "
    "1 special charecter (@\$!%*-?&^~)";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_HINT =
    "Re-Enter your password";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_LABEL = "Confirm Password";
const String PASSWORD_RESET_SCREEN_CONFIRM_PASSWORD_ERROR =
    "Passwords do not match!";
const String PASSWORD_RESET_PASSWORD_BUTTON = "Reset Password";
const String PASSWORD_RESET_SCREEN_LOADING_MESSAGE =
    "Setting new password and loggin in!";
