import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bottom_navigationbar/repo/helper/image_helper.dart';

class ImageNetworkRepository {
  Future<void> uploadImageNCreateNewPost(File originImage) async {
    try {
      final File resized = await compute(getResizedImage, originImage);
      originImage
          .length()
          .then((value) => print('### original image size : $value'));
      resized
          .length()
          .then((value) => print('### resized image size : $value'));
      print('### is Logged : originImage : ' + originImage.toString());
      print('### is Logged : getResizedImage : ' +
          getResizedImage(originImage).toString());
    } catch (e) {}
  }
}

ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();
