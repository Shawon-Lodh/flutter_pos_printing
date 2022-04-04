
import 'dart:typed_data';

import 'package:image/image.dart';

class ImageProcessUtils {
  // Future<Image> makeImageForPrint(Uint8List data) async{
  //   // final Image? image = decodeImage(theimageThatC);
  //   // return image!;
  //   // Uint8List? resizedData = data;
  //   Image? img = decodeImage(data);
  //   Image resized = copyResize(img!, width: 300, height: img.height);
  //   return resized;
  // }

  Future<Image> makeImageForPrint(Uint8List theimageThatC) async{
    final Image? image = decodeImage(theimageThatC);
    Image resized = copyResize(image!, width: 600, height: image.height);
      return resized;
    // return image!;
    // return copyResize(image!, width: 600);
  }

}