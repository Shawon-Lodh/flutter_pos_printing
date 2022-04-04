/*
    Created by Shawon lodh on 2 January 2022
*/

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/common/constants/app_constants.dart';
import 'package:flutter_pos_printing/common/widgets/widget_ripple_animation.dart';
import 'package:flutter_pos_printing/pages/printReceipt/data/data_bluetooth_devices.dart';
import 'package:flutter_pos_printing/pages/printReceipt/data/data_print_receipt.dart';
import 'package:flutter_pos_printing/pages/printReceipt/presenter_print_receipt.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';

class PrintReceiptScreenReceiveData extends StatelessWidget {
  const PrintReceiptScreenReceiveData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    return PrintReceiptScreen(receiveData: arguments,);
  }

}

class PrintReceiptScreen extends StatefulWidget {
  final receiveData;
  const PrintReceiptScreen({Key? key, this.receiveData}) : super(key: key);
  @override
  _PrintReceiptScreenState createState() => _PrintReceiptScreenState();
}

class _PrintReceiptScreenState extends State<PrintReceiptScreen>{

  PrintReceiptScreenData? _printReceiptScreenData;

  PrintReceiptScreenPresenter? _printReceiptScreenPresenter;

  @override
  void initState() {
    _printReceiptScreenData = PrintReceiptScreenData(
      isBluetoothOn: ValueNotifier(false),
      isLocationOn: ValueNotifier(false),
      bluetoothDevicesData: BluetoothDevicesData(printerBluetoothManager: PrinterBluetoothManager(),bluetoothDevicesData: ValueNotifier([])),
      printButtonVisible: ValueNotifier(false),
      printStartStatus: ValueNotifier(false),
      printImageData: widget.receiveData['printImageData'],
    );
    _printReceiptScreenPresenter = PrintReceiptScreenPresenter(context, _printReceiptScreenData!);
    _printReceiptScreenPresenter?.checkBluetoothAndLocationInStarting();
    // _printReceiptScreenPresenter?.listenBluetoothDevices();
    super.initState();
  }

  @override
  void dispose() {
    _printReceiptScreenPresenter!.stopScanBluetoothDevices();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CommonUtil.instance.notificationStatusBarShow(show: true);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(backgroundColor: const Color(0xffc88719),title: Text(AppConstants.instance.appbarTitle,style: const TextStyle(fontSize: 16),),),
        body: ValueListenableBuilder(
          valueListenable: _printReceiptScreenData!.isBluetoothOnValue,
          builder: (context, bool bluetoothStatusValue, child) {
            return Center(
              child: ValueListenableBuilder(
                valueListenable: _printReceiptScreenData!.isLocationOnValue,
                builder: (context, bool locationStatusValue, child) {
                  return !(bluetoothStatusValue && locationStatusValue) ? _getHardwareConnectionPanel(bluetoothStatusValue: bluetoothStatusValue, locationStatusValue: locationStatusValue) : _getAllBlueToothDevicesInformation();
                },
              ),
            );
          },
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: _printReceiptScreenData!.printButtonVisibleValue,
          builder: (context, bool printButtonVisibleValue, child) {
            return Visibility(
              visible: printButtonVisibleValue,
              child: FloatingActionButton(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/images/ic_print_button.svg',
                    width: 64,
                    height: 64,
                  ),
                ),
                onPressed: (){
                  print("Pressed");
                  _printReceiptScreenPresenter!.sendDataToPrinterAndCompletePrinting();
                },
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(side: const BorderSide(width: 5,color: Color(0xffc88719)),borderRadius: BorderRadius.circular(100)),
              ),
            );
          },
        ),
      ),
    );
  }

  ///UI
  // Widget _getPageTitle() {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 20.h),
  //     child: GenericPageTitle(
  //       showBackButton: true,
  //       topText: "Transport Permit/",
  //       bottomText: "Print TP",
  //       backButtonPress: _printTpScreenPresenter!
  //           .goToCreateTPPage(),
  //     ),
  //   );
  // }

  Widget _getHardwareConnectionPanel({required bool bluetoothStatusValue, required bool locationStatusValue}) {
    return Visibility(
      visible: !(bluetoothStatusValue && locationStatusValue),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: [
            _getHardwareConnectionPanelTitle(),
            _getHardwareConnectionPanelBody(),
            _getTutorialForTurnOnHardwareConnection(bluetoothStatusValue, locationStatusValue),
          ],
        ),
      ),
    );
  }

  Widget _getTutorialForTurnOnHardwareConnection(bool bluetoothStatusValue, bool locationStatusValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getTutorialContentItemForTurnOnHardwareConnection(visibilityStatus: bluetoothStatusValue, imageAddress: 'assets/lottiefiles/lottie_turn_on_bluetooth.zip', text: "Please\nTurn on BlueTooth"),
          _getTutorialContentItemForTurnOnHardwareConnection(visibilityStatus: locationStatusValue, imageAddress: 'assets/lottiefiles/lottie_turn_on_gps.zip', text: "Please\nTurn on Gps"),
        ],
      ),
    );
  }

  Widget _getTutorialContentItemForTurnOnHardwareConnection({required bool visibilityStatus, required String imageAddress, required String text}) {
    return Visibility(
      visible: !visibilityStatus,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                imageAddress, width: 160),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xFFFB4B4B),
                  fontSize: 12,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHardwareConnectionPanelBody() {
    return Visibility(
      visible: !(_printReceiptScreenData!.isBluetoothOnValue.value && _printReceiptScreenData!.isLocationOnValue.value),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getHardwareActiveButton(
              activeImageAddress: 'assets/images/ic_bluetooth_selection_on.svg',
              nonActiveImageAddress:
              'assets/images/ic_bluetooth_selection_off.svg',
              title: AppConstants.instance.bluetooth,
              buttonStatus: _printReceiptScreenData!.isBluetoothOnValue,
              buttonStatusChangeFunction: _printReceiptScreenPresenter!.toggleBluetoothButton,
            ),
            const SizedBox(width: 30),
            _getHardwareActiveButton(
              activeImageAddress: 'assets/images/ic_gps_selection_on.svg',
              nonActiveImageAddress: 'assets/images/ic_gps_selection_off.svg',
              title: AppConstants.instance.location,
              buttonStatus: _printReceiptScreenData!.isLocationOnValue,
              buttonStatusChangeFunction: _printReceiptScreenPresenter!.toggleLocationButton,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHardwareActiveButton(
      {required String activeImageAddress,
      required String nonActiveImageAddress,
      required String title,
      required ValueNotifier<bool> buttonStatus,
      required Function(bool)? buttonStatusChangeFunction}) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: const Color(0xffc88719),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// active dot circle
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xffc88719),
              shape: BoxShape.circle,
            ),
          ),

          /// hardware active button body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ValueListenableBuilder(
              valueListenable: buttonStatus,
              builder: (context, bool buttonStatusValue, child) {
                return Column(
                  children: [
                    SvgPicture.asset(
                      buttonStatusValue
                          ? activeImageAddress
                          : nonActiveImageAddress,
                      height: 24,
                      width: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Color(0xffc88719),
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        onChanged: buttonStatusChangeFunction,
                        value: buttonStatusValue,
                        activeColor: const Color(0xffc88719),
                        activeTrackColor:
                        const Color(0xFFAAAAAA).withOpacity(0.5),
                        inactiveTrackColor:
                        const Color(0xFFAAAAAA).withOpacity(0.5),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getHardwareConnectionPanelTitle() {
    return Text(
      AppConstants.instance.deviceManagePermission,
      style: const TextStyle(
          color: Color(0xffAAAAAA),
          fontSize: 16,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold),
    );
  }

  Widget _getAllBlueToothDevicesInformation() {
    return Builder(
      builder: (BuildContext contex){
        _printReceiptScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.isEmpty ? _printReceiptScreenPresenter!.startScanBluetoothDevices() : null;
        return StreamBuilder<bool>(
          stream: _printReceiptScreenData!.bluetoothDevicesData.printerBluetoothManager.isScanningStream,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data!) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    AppConstants.instance.searchingDevices,
                    style: const TextStyle(
                        color: Color(0xffc88719),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppConstants.instance.waitingFewSeconds,
                    style: const TextStyle(
                        color: Color(0xffAAAAAA),
                        fontSize: 16,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: RippleAnimation(
                    color: const Color(0xffAAAAAA),
                    child: SvgPicture.asset('assets/images/ic_pos_printer.svg'),)),
                ],
              );
            } else {
              return _printReceiptScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.isNotEmpty ? Column(
                children: [
                  const SizedBox(height: 20),
                  _getRetryButton(buttonText: AppConstants.instance.scanMore),
                  Text(
                    AppConstants.instance.totalFoundDevices + _printReceiptScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.length.toString(),
                    style: const TextStyle(
                        color: Color(0xffc88719),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppConstants.instance.selectDevices,
                    style: const TextStyle(
                        color: Color(0xffAAAAAA),
                        fontSize: 16,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _printReceiptScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: _selectDeviceForPrint(index),
                            child: _getBlDevicesDetailsCard(
                              deviceName: _printReceiptScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value[index].name.toString(),
                              deviceAddress: _printReceiptScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value[index].address.toString(),
                              selected: _printReceiptScreenData!.bluetoothDevicesData.allFoundDevicesSelectionStatus![index],
                            ),
                          );
                        }),
                  ),
                ],
              ) : Column(
                children: [
                  Text(
                    AppConstants.instance.noDevicesFound,
                    style: const TextStyle(
                        color: Color(0xffc88719),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  _getRetryButton(buttonText: AppConstants.instance.retry),
                ],
              );
            }
          },
        );
      },
    );
  }

  Widget _getBlDevicesDetailsCard({String? deviceName,String? deviceAddress, bool selected = false}) {
    return Container(
      // constraints: BoxConstraints(minHeight: 0, maxHeight: 90.h),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      alignment: Alignment.center,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [

          Positioned.fill(
            top: 20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: selected ? const Color(0xffc88719) : const Color(0xffAAAAAA),
                  width: 2,
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffAAAAAA).withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 90,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            deviceName ?? "",
                            style: const TextStyle(
                                color: Color(0xffc88719),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            (deviceAddress!= null) ? (AppConstants.instance.address + deviceAddress) : "",
                            style: const TextStyle(
                                color: Color(0xffc88719),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            AppConstants.instance.bluetoothDevice,
                            style: const TextStyle(
                                color: Color(0xffAAAAAA),
                                fontSize: 12,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Visibility(visible: selected, child: const FaIcon(FontAwesomeIcons.checkCircle,size: 32)),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 20,
            bottom: 20,
            child: SvgPicture.asset(
              'assets/images/ic_pos_printer.svg',
              color: const Color(0xffc88719),
              height: 80,
            ),
          ),

          Container(
            height: 110,
          )

        ],
      ),
    );
  }

  Widget _getRetryButton({required String buttonText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: OutlinedButton(
        onPressed: _printReceiptScreenPresenter!.retryButtonFunctionality,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 75,vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60),),
          side: const BorderSide(width: 1, color: Color(0xffc88719),style: BorderStyle.solid,),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Color(0xffc88719),
          ),
        ),
      ),
    );
  }

  /// functions

  _selectDeviceForPrint(int index){
    return(){
      setState(() {
        _printReceiptScreenData!.bluetoothDevicesData.allFoundDevicesSelectionStatusValue = List.filled(_printReceiptScreenData!.bluetoothDevicesData.bluetoothDevicesDataValue.value.length, false);
        _printReceiptScreenData!.bluetoothDevicesData.allFoundDevicesSelectionStatus![index] = !(_printReceiptScreenData!.bluetoothDevicesData.allFoundDevicesSelectionStatus![index]);
        _printReceiptScreenData!.printButtonVisibleValue.value = true;
      });
    };
  }

}
