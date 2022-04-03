/*
    Created by Shawon Lodh on 01 February 2022
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_pos_printing/common/constants/app_routes.dart';
import 'package:flutter_pos_printing/common/utils/app_navigation_util.dart';
import 'package:flutter_pos_printing/pages/printReceipt/data/data_print_receipt.dart';
import 'package:location/location.dart';

class PrintReceiptScreenPresenter {
  BuildContext context;
  PrintReceiptScreenData _printReceiptScreenData;

  /// Handle Over-tapping
  DateTime? initialClickTime;

  /// Constructor
  PrintReceiptScreenPresenter(this.context, this._printReceiptScreenData);

  ///Navigation
  goToCreateTPPage() {
    return () {
      NavigatorUtil.instance.goToPreviousPage(context);
    };
  }

  Future checkBluetoothAndLocationInStarting() async {
    _printReceiptScreenData.isBluetoothOnValue.value = await bluetoothCheck();
    _printReceiptScreenData.isLocationOnValue.value = await gpsCheck();
    if (_printReceiptScreenData.isBluetoothOnValue.value &&
        _printReceiptScreenData.isLocationOnValue.value) {
      startScanBluetoothDevices();
    }
  }

  toggleBluetoothButton(bool value) {
    if (!isRedundantClick(DateTime.now(), 1)) {
      future() async {
        try {
          if (value) {
            _printReceiptScreenData.isBluetoothOnValue.value =
                (await FlutterBluetoothSerial.instance.requestEnable())!;
          }
          // else {
          //   _printTpScreenData.isBluetoothOnValue.value =
          //   (await FlutterBluetoothSerial.instance.requestDisable())!;
          // }
        } catch (e) {
          print(e);
        }
      }

      future().then((_) {});
    }
  }

  toggleLocationButton(bool value) {
    if (!isRedundantClick(DateTime.now(), 1)) {
      future() async {
        try {
          gpsCheck().then((value) async {
            if (value) {
              if (_printReceiptScreenData.isLocationOnValue.value != null) {
                _printReceiptScreenData.isLocationOnValue.value =
                    _printReceiptScreenData.isLocationOnValue.value;
              }
            } else {
              // Geolocator.openLocationSettings();
              if (!await Location().serviceEnabled()) {
                Location().requestService().then((value) {
                  if (value) {
                    print("SuccessFully Turned on");
                    _printReceiptScreenData.isLocationOnValue.value = true;
                  } else {
                    print("Failed to Turn on");
                    _printReceiptScreenData.isLocationOnValue.value = false;
                  }
                });
              } else {
                Location().requestService().then((value) {
                  if (value) {
                    print("SuccessFully Turned on");
                    _printReceiptScreenData.isLocationOnValue.value = true;
                  } else {
                    print("Failed to Turn on");
                    _printReceiptScreenData.isLocationOnValue.value = false;
                  }
                });
              }
            }
          });
        } catch (e) {
          print(e);
        }
      }

      future().then((_) {});
    }
  }

  listenBluetoothDevices() {
    _printReceiptScreenData
        .bluetoothDevicesData.printerBluetoothManager.scanResults
        .listen((devices) async {
      _printReceiptScreenData
          .bluetoothDevicesData.bluetoothDevicesDataValue.value = devices;
      for (int i = 0;
          i <
              _printReceiptScreenData
                  .bluetoothDevicesData.bluetoothDevicesDataValue.value.length;
          i++) {
        print(
            "Name : ${_printReceiptScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value[i].name}, Address : ${_printReceiptScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value[i].address}, Type : ${_printReceiptScreenData.bluetoothDevicesData.bluetoothDevicesDataValue.value[i].type}");
      }
      _printReceiptScreenData
              .bluetoothDevicesData.allFoundDevicesSelectionStatusValue =
          List.filled(
              _printReceiptScreenData
                  .bluetoothDevicesData.bluetoothDevicesDataValue.value.length,
              false);
    });
  }

  startScanBluetoothDevices() {
    _printReceiptScreenData
        .bluetoothDevicesData.bluetoothDevicesDataValue.value = [];
    _printReceiptScreenData.bluetoothDevicesData.printerBluetoothManager
        .startScan(const Duration(seconds: 4));
  }

  stopScanBluetoothDevices() {
    _printReceiptScreenData.bluetoothDevicesData.printerBluetoothManager
        .stopScan();
  }

  sendDataToPrinterAndCompletePrinting() async {
    if (!isRedundantClick(DateTime.now(), 3)) {
      for (int i = 0;
          i < _printReceiptScreenData.bluetoothDevicesData
                  .allFoundDevicesSelectionStatusValue!.length;
          i++) {
        if (_printReceiptScreenData
            .bluetoothDevicesData.allFoundDevicesSelectionStatusValue![i]) {
          print("no is : $i");
          final data = await NavigatorUtil.instance.goToNextScreenWithData(
              context, AppRoutes.printingOnPosMachinePage, {
            'printerManager': _printReceiptScreenData
                .bluetoothDevicesData.printerBluetoothManager,
            'selectedPrinter': _printReceiptScreenData
                .bluetoothDevicesData.bluetoothDevicesDataValue.value[i],
            'printImageData' : _printReceiptScreenData.printImageData,
          });
          if (data != null && data == true) {
            retryButtonFunctionality();
          }
        }
      }
    }
  }

  retryButtonFunctionality() {
    _printReceiptScreenData.printButtonVisibleValue.value = false;
    startScanBluetoothDevices();
  }

  /// GPS Check
  Future<bool> gpsCheck() async {
    return await Location.instance.serviceEnabled();
  }

  /// Bluetooth Check
  Future<bool> bluetoothCheck() async {
    return (await FlutterBluetoothSerial.instance.isEnabled)!;
  }

  bool isRedundantClick(DateTime currentTime, int redundantClickDuration) {
    if (initialClickTime == null) {
      initialClickTime = currentTime;
      return false;
    } else {
      if (currentTime.difference(initialClickTime!).inSeconds <
          redundantClickDuration) {
        //set this difference time in seconds (ideally 3 sec)
        return true;
      }
    }
    initialClickTime = currentTime;
    return false;
  }
}
