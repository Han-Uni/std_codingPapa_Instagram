import 'dart:io';
import 'package:image/image.dart';

File getResizedImage(File originImage) {
  Image? image = decodeImage(originImage.readAsBytesSync());
  Image? resizedImage = copyResizeCropSquare(image!, 300);

  print('### is Logged : origin Image path : $originImage');

  File resizedFile =
      File(originImage.path.substring(0, originImage.path.length - 3) + "png");
  resizedFile.writeAsBytesSync(encodeJpg(resizedImage, quality: 30));
  print('### is Logged : resizedFile  path : $resizedFile');
  return resizedFile;
}
