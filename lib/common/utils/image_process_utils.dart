
import 'dart:typed_data';

import 'package:image/image.dart';

class ImageProcessUtils {
  Future<Image> makeImageForPrint(Uint8List theimageThatC) async{
    final Image? image = decodeImage(theimageThatC);
    return image!;
    // return copyResize(image!, width: 600);
  }
}