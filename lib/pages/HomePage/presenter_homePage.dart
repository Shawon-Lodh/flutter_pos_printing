import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/common/constants/app_routes.dart';
import 'package:flutter_pos_printing/common/utils/app_navigation_util.dart';
import 'package:flutter_pos_printing/pages/HomePage/data_homePage.dart';

class HomePageScreenPresenter {
  BuildContext? context;
  HomePageScreenData? _homePageScreenData;

  /// Handle Over-tapping
  DateTime? initialClickTime;

  /// Constructor
  HomePageScreenPresenter(this.context, this._homePageScreenData);

  sendDataForPrinting() async {
    if (!isRedundantClick(DateTime.now(), 3)) {
      await _homePageScreenData!.screenshotControllerValue
          !.capture(delay: const Duration(milliseconds: 10))
          .then((capturedImage) async {
        _homePageScreenData!.printImageDataValue = capturedImage!;
        await NavigatorUtil.instance.goToNextScreenWithData(
            context!, AppRoutes.printReceiptPage, {
          'printImageData' : _homePageScreenData!.printImageDataValue,
        });
      }).catchError((onError) {
        print(onError);
      });
    }
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