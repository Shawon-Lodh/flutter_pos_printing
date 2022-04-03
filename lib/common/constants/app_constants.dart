class AppConstants {

  static AppConstants instance = AppConstants();

  // pop up menu bar
  String english = 'english';
  String bangla = 'bangla';
  List<String>popUpChoices = ['english','bangla'];

  //app Bar
  String appbarTitle = "Portable Mobile Bluetooth Receipt Printer";

  //persistant footer button
  String printReceipt = "Print";

  //backbutton pressed
  String get wannaBackToPreviousPage => 'Do you want to go Previous page?';
  String get wannaLogout => 'Do you want to Log Out?';
  String get wannaExit => 'Do you want to Exit the App?';
  String get cancel => 'Cancel';
  String get exit => 'Exit';
  String get yes => 'Yes';
  String get no => 'No';

  // print Receipt page
  String get bluetooth => "Bluetooth";
  String get location => "Location";
  String get deviceManagePermission => "Start Managing Your Permission";
  String get searchingDevices => "Searching for Devices...";
  String get waitingFewSeconds => "It is going to take only few seconds";
  String get totalFoundDevices => "Total Devices Found : ";
  String get selectDevices => "Select device & tap for confirm to print";
  String get noDevicesFound => "No Devices Found";
  String get retry => "Retry";
  String get scanMore => "Scan More Devices";
  String get address => "Address : ";
  String get bluetoothDevice => "BlueTooth Device";
}