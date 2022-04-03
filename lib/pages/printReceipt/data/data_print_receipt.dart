/*
    Created by Shawon Lodh on 01 February 2022
*/

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/pages/printReceipt/data/data_bluetooth_devices.dart';

class PrintReceiptScreenData {
  ValueNotifier<bool> isBluetoothOn;
  ValueNotifier<bool> isLocationOn;
  BluetoothDevicesData bluetoothDevicesData;
  ValueNotifier<bool> printButtonVisible;
  ValueNotifier<bool> printStartStatus;
  Uint8List? printImageData;

  /// Constructor
  PrintReceiptScreenData({required this.isBluetoothOn,required this.isLocationOn, required this.bluetoothDevicesData , required this.printButtonVisible, required this.printStartStatus, required this.printImageData});


  /// Bluetooth On status
  ValueNotifier<bool> get isBluetoothOnValue{
    return isBluetoothOn;
  }

  set isBluetoothOnValue(ValueNotifier<bool> valueIsBluetoothOn) {
    isBluetoothOn = valueIsBluetoothOn;
  }

  /// Location On status
  ValueNotifier<bool> get isLocationOnValue{
    return isLocationOn;
  }

  set isLocationOnValue(ValueNotifier<bool> valueIsLocationOn) {
    isLocationOn = valueIsLocationOn;
  }

  /// Print Button Visible
  ValueNotifier<bool>  get printButtonVisibleValue{
    return printButtonVisible;
  }

  set printButtonVisibleValue(ValueNotifier<bool>  valuePrintButtonVisible) {
    printButtonVisible = valuePrintButtonVisible;
  }

  /// Print Start Status
  ValueNotifier<bool> get printStartStatusValue{
    return printStartStatus;
  }

  set printStartStatusValue(ValueNotifier<bool>  valuePrintStartStatus) {
    printStartStatus = valuePrintStartStatus;
  }

  /// print Image Data
  Uint8List? get printImageDataValue{
    return printImageData;
  }

  set printImageDataValue(Uint8List? valuePrintImageData) {
    printImageData = valuePrintImageData;
  }

}