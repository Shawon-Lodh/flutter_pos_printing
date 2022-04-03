import 'package:flutter/material.dart';
import 'package:flutter_pos_printing/pages/HomePage/screen_homePage.dart';
import 'package:flutter_pos_printing/pages/printReceipt/screen/screen_print_receipt.dart';
import 'package:flutter_pos_printing/pages/printReceipt/screen/screen_printing_on_pos_machine.dart';

class AppRoutes {

  /// All pages
  static const String splashPageAddress= 'splash';
  static const String homePageAddress= '/home';
  static const String printReceiptPage= '/printReceiptPage';
  static const String printingOnPosMachinePage= '/printingOnPosMachinePage';

  /// All Routes
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      // case splashPageAddress:
      //   return MaterialPageRoute(builder: (BuildContext context) => SplashPage());
      case homePageAddress:
        return MaterialPageRoute(builder: (BuildContext context) => HomePageScreen());
      case printReceiptPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (ctx) => PrintReceiptScreenReceiveData(),
        );
      case printingOnPosMachinePage:
        return MaterialPageRoute(
          settings: settings,
          builder: (ctx) => ScreenPrintingOnPosMachineReceiveData(),
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute(builder: (BuildContext context) => HomePageScreen());
    }
  }

}