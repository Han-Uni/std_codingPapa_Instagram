import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:local_image_provider/local_image_provider.dart';

class GalleryState extends ChangeNotifier {
  LocalImageProvider? _localImageProvider;
  bool? _hasPermission;
  List<LocalImage>? _images;

  Future<bool> initProvider() async {
    _localImageProvider = LocalImageProvider();
    _hasPermission = await _localImageProvider!.initialize();
    log('### y_log : hasPermission 확인!!! + $_hasPermission');
    if (_hasPermission!) {
      // .findLatest : 기기에서 n개의 이미지를 가지고와서 보여주기
      _images = await _localImageProvider!.findLatest(30);
      notifyListeners();
      log('### y_log : if로 들어오는지 확인 !!!');
      return true;
    } else {
      return false;
    }
  }

  List<LocalImage>? get images => _images;
  LocalImageProvider? get localImageProvider => _localImageProvider;
}
