/*
    Created by Shawon Lodh on 02 March 2022
*/


// import 'package:agrotracetobacco/common/core/utils/app_navigation_util.dart';
import 'dart:typed_data';

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/common/constants/app_constants.dart';
import 'package:flutter_pos_printing/common/utils/app_navigation_util.dart';
import 'package:flutter_pos_printing/common/utils/image_process_utils.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class ScreenPrintingOnPosMachineReceiveData extends StatelessWidget {
  const ScreenPrintingOnPosMachineReceiveData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    return ScreenPrintingOnPosMachine(receiveData: arguments,);
  }

}

class ScreenPrintingOnPosMachine extends StatefulWidget {
  final receiveData;
  ScreenPrintingOnPosMachine({Key? key, this.receiveData}) : super(key: key);
  @override
  _ScreenPrintingOnPosMachineState createState() => _ScreenPrintingOnPosMachineState();
}

class _ScreenPrintingOnPosMachineState extends State<ScreenPrintingOnPosMachine>{

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PrinterBluetoothManager? printerBluetoothManager;
  PrinterBluetooth? selectedPrinter;
  Uint8List? printImageData;

  @override
  void initState() {
    printerBluetoothManager = widget.receiveData['printerManager'];
    selectedPrinter = widget.receiveData['selectedPrinter'];
    printImageData = widget.receiveData['printImageData'];
    super.initState();
  }

  @override
  void dispose() {
    printerBluetoothManager = null;
    selectedPrinter = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backButtonPressed,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: FutureBuilder(
            future: _createPrint(selectedPrinter!),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/lottiefiles/lottie_printing.zip',height: 300),
                            const FittedBox(
                              child: Text("Please wait...\nprinting process is started...", textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xff424242),
                                    fontSize: 24,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset('assets/lottiefiles/lottie_error.zip',height: 300),
                              FittedBox(
                                child: Text(snapshot.error.toString(), textAlign: TextAlign.center,
                                  style: const TextStyle(color: Color(0xFFFB4B4B),
                                      fontSize: 32,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    if(snapshot.data.toString() == "Success"){
                      // NavigatorUtil.instance.goToPreviousPage(context).then((value){
                      //   NavigatorUtil.instance.goToPreviousPageWithData(context,data: true);
                      // });
                      return Container();
                    }else{
                      return Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/lottiefiles/lottie_error.zip',width: 300),
                                FittedBox(
                                  child: Text(snapshot.data.toString(), textAlign: TextAlign.center,
                                    style: const TextStyle(color: Color(0xFFFB4B4B),
                                        fontSize: 32,
                                        fontFamily: "Raleway",
                                        fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(height: 20,),
                                _getRetryButton(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }

                default:
                  return const FittedBox(
                    child: Text("Unhandle State", textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFFB4B4B),
                          fontSize: 32,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold),),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  ///UI

  Widget _getRetryButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: OutlinedButton(
        onPressed: (){
          NavigatorUtil.instance.goToPreviousPageWithData(context, data: true);
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60),),
          side: const BorderSide(width: 3, color: Color(0xFFFB4B4B),style: BorderStyle.solid,),
        ),
        child: const Text(
          "Retry",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Color(0xFFFB4B4B),
          ),
        ),
      ),
    );
  }

  ///functions

  Future<List<int>> _createReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    bytes += ticket.image(await ImageProcessUtils().makeImageForPrint(printImageData!), align: PosAlign.center);
    ticket.feed(2);
    ticket.cut();
    return bytes;
  }

  _createPrint(PrinterBluetooth printer) async {
    printerBluetoothManager!.selectPrinter(selectedPrinter!);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm80;

    final profile = await CapabilityProfile.load();

    try{
      // Final RECEIPT
      final PosPrintResult res =
      await printerBluetoothManager!.printTicket((await _createReceipt(paper, profile)));
      print(res);
    } catch (e) {
      print(e);
      // do stuff
    }
  }

  /// backPress Dialogs
  Future<bool> _backButtonPressed() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      // _scaffoldKey.currentState?.openEndDrawer();
      Dialogs.materialDialog(
          msg: AppConstants.instance.wannaBackToPreviousPage,
          color: Colors.white,
          context: context,
          actions: [
            IconsOutlineButton(
              onPressed: () {
                NavigatorUtil.instance.goToPreviousPage(context);
              },
              text: AppConstants.instance.no,
              iconData: Icons.cancel_outlined,
              textStyle: const TextStyle(color: Colors.grey),
              iconColor: Colors.grey,
            ),
            IconsButton(
              onPressed: () {
                NavigatorUtil.instance.goToPreviousPage(context);
                NavigatorUtil.instance.goToPreviousPage(context);
              },
              text:AppConstants.instance.exit,
              iconData: Icons.exit_to_app,
              color: Colors.red,
              textStyle: const TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
              iconColor: Colors.white,
            ),

          ]);
    }
    return false;
  }
  
}
