import 'dart:typed_data';

import 'package:screenshot/screenshot.dart';

class HomePageScreenData {

  ScreenshotController? screenshotController;
  Uint8List? printImageData;

  /// Constructor
  HomePageScreenData({required this.screenshotController, this.printImageData});

  /// Screen sort controller
  ScreenshotController? get screenshotControllerValue{
    return screenshotController;
  }

  set screenshotControllerValue(ScreenshotController? valueScreenshotController) {
    screenshotController = valueScreenshotController;
  }

  /// print Image Data
  Uint8List? get printImageDataValue{
    return printImageData;
  }

  set printImageDataValue(Uint8List? valuePrintImageData) {
    printImageData = valuePrintImageData;
  }

}