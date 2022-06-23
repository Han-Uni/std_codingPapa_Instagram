import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bottom_navigationbar/repo/helper/image_helper.dart';

class ImageNetworkRepository {
  Future<TaskSnapshot?> uploadImage(File originImage,
      {@required String? postKey}) async {
    try {
      final File resized = await compute(getResizedImage, originImage);
      // final FirebaseStorage storage = FirebaseStorage.instanceFor();
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(_getImagePathByPostKey(postKey!));
      final UploadTask uploadTask = storageReference.putFile(resized);

      originImage
          .length()
          .then((value) => print('### is Logged : originImage :  $value'));
      resized
          .length()
          .then((value) => print('### is Logged : resized : $value'));

      final listResult = await storageReference.listAll();
      print('### is Logged : uploadTask.snapshot : ' +
          uploadTask.snapshot.toString());
      return uploadTask.snapshot;
    } on FirebaseException catch (e) {
      print("### is Logged : e : '${e.code}' : ${e.message}");
    }
  }

  String _getImagePathByPostKey(String postKey) => 'post/$postKey/post.jpg';

  Future<dynamic> getPostImageUrl(String postKey) {
    return FirebaseStorage.instance
        .ref()
        .child(_getImagePathByPostKey(postKey))
        .getDownloadURL();
  }
}

ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();
